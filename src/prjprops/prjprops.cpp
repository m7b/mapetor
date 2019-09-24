#include "prjprops/prjprops.h"

t_ProjectProperties ProjectProperties
{
    std::make_tuple(MAPC_PATH,   "SET MAPC=",        "\\path\\to\\MAPC"),  //Maperitive Console
    std::make_tuple(MAPG_PATH,   "SET MAPG=",        "\\path\\to\\MAPG"),  //Maperitive GUI
    std::make_tuple(IMCO_PATH,   "SET IMCO=",        "\\path\\to\\IMCO"),  //ImageMagick Convert
    std::make_tuple(IMID_PATH,   "SET IMID=",        "\\path\\to\\IMID"),  //ImageMagick Identify
    std::make_tuple(INKS_PATH,   "SET INKS=",        "\\path\\to\\INKS"),  //Inkscape

    std::make_tuple(CARD_ORIENTATION,
                    "SET Orientation=",
                    "landscape or portrait"),  //Map orientation landscape/portrait

    std::make_tuple(CARD_PAPERHEIGHT_MM,
                    "SET PaperHeight_mm=",
                    "90"),                     //Paper height [mm]

    std::make_tuple(CARD_PAPERWIDTH_MM,
                    "SET PaperWidth_mm=",
                    "140"),                    //Paper width [mm]

    std::make_tuple(MAP_CENTER,
                    "SET MapCenter=",
                    "ww.xx,yy.zz"),            //Map center

    std::make_tuple(MAP_SCALE,
                    "SET MapScale=",
                    "4444"),                   //Map scale

    std::make_tuple(MAP_DPI,             "SET MapDpi=",         "1200"),                   //Map dpi
    std::make_tuple(MAP_USE_GRID,        "SET UseGrid=",        "true"),                   //Map dpi
    std::make_tuple(MAP_USE_ATTRIBUTION, "SET UseAttribution=", "true"),                   //Map dpi
    std::make_tuple(MAP_USE_SCALE,       "SET UseScale=",       "true"),                   //Map dpi

    std::make_tuple(OSM_PATH,
                    "SET OSM=",
                    "\\path\\to\\OSM"),   //OSM File

    std::make_tuple(OSM_SERVICE_URL,
                    "SET ServiceURL=",
                    "\"http://www.overpass-api.de/api/interpreter?*\""),   //OSM File

    std::make_tuple(OSM_GEOMETRY_BOUNDS,
                    "SET OSM_GEOMETRY_BOUNDS=",
                    "ww,xx,yy,zz")    //OSM Borders
};


bool find_key_positions(const std::string *prj_file,
                        const t_SingleProp *prop,
                        size_t *key_start_pos,
                        size_t *key_eol_pos)
{
    bool rc = false;
    t_key key = std::get<e_key>(*prop);

    *key_start_pos = prj_file->find(key);
    if (*key_start_pos == std::string::npos)
        return rc;

    *key_eol_pos   = prj_file->find('\n', *key_start_pos);
    if (*key_eol_pos == std::string::npos)
        return rc;

    rc = true;

    return rc;
}

void write_props(std::string *prj_file)
{
    for (auto const &el : ProjectProperties)
    {
        size_t key_start_pos, key_eol_pos;
        bool rc = find_key_positions(prj_file, &el, &key_start_pos, &key_eol_pos);
        if (rc)
            write_key(prj_file, &el, &key_start_pos, &key_eol_pos);
    }
}

bool write_key(std::string *prj_file,
               const t_SingleProp *prop,
               const size_t *key_start_pos,
               const size_t *key_eol_pos)
{
    t_key key     = std::get<e_key>(*prop);
    t_value value = std::get<e_value>(*prop);

    size_t start  = *key_start_pos + key.size(); //Position of key
    size_t amount = *key_eol_pos - *key_start_pos - key.size(); //Amount chars from key end to eol

    std::string fff = prj_file->replace(start, amount, value);

    return true;
}

void read_props(const std::string *prj_file)
{
    for (auto &el : ProjectProperties)
    {
        size_t key_start_pos, key_eol_pos;
        bool rc = find_key_positions(prj_file, &el, &key_start_pos, &key_eol_pos);
        if (rc)
            read_key(prj_file, &el, &key_start_pos, &key_eol_pos);
    }
}

bool read_key(const std::string *prj_file,
              t_SingleProp *prop,
              const size_t *key_start_pos,
              const size_t *key_eol_pos)
{
    t_key key     = std::get<e_key>(*prop);

    size_t start  = *key_start_pos + key.size(); //Position of key
    size_t amount = *key_eol_pos - *key_start_pos - key.size(); //Amount chars from key end to eol

    t_value value = prj_file->substr(start, amount);
    std::get<e_value>(*prop) = value;

    return true;
}

t_value get_prop_val(const prop_names n)
{
    for (auto const &el : ProjectProperties)
    {
        t_name prop_name = std::get<e_name>(el);
        if (prop_name == n)
            return std::get<e_value>(el);
    }

    return "";
}

bool set_prop_val(const prop_names n, const t_value val)
{
    for (auto &el : ProjectProperties)
    {
        t_name prop_name = std::get<e_name>(el);
        if (prop_name == n)
        {
            std::get<e_value>(el) = val;
            return true;
        }
    }

    return false;
}
