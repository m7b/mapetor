#include "gui/C_wxMainFrame.h"

C_wxMainFrame::C_wxMainFrame( wxWindow* parent )
:
C_wxfbMainFrame( parent )
{
    SetIcon(wxICON(MAINICON));
    SetTitle(VER_PRODUCTNAME_STR);

    m_length = .0;
    m_height = .0;

    m_inkscape_file_content.clear();
    m_project_file.clear();
    m_project_file_content.clear();

    init_validators();
    init_textctrl_length_width();
    init_filepickers();

    //read_settings();
}

C_wxMainFrame::~C_wxMainFrame()
{
    //write_settings();
}


void C_wxMainFrame::init_validators(void)
{
    //max DIN-A4

    //Validator for map length
    wxFloatingPointValidator<double> lenght_val(1, &m_length, wxNUM_VAL_ZERO_AS_BLANK);
    lenght_val.SetRange(.0, 297.0);
    m_textCtrl_length->SetValidator(lenght_val);

    //Validator for map height
    wxFloatingPointValidator<double> height_val(1, &m_height, wxNUM_VAL_ZERO_AS_BLANK);
    height_val.SetRange(.0, 420.0);
    m_textCtrl_height->SetValidator(height_val);

    //Validator for scale
    wxFloatingPointValidator<double> scale_val(1, &m_scale, wxNUM_VAL_ZERO_AS_BLANK);
    scale_val.SetRange(.0, 200000.0);
    m_textCtrl_scale->SetValidator(scale_val);
}


void C_wxMainFrame::init_textctrl_length_width(void)
{
    wxCommandEvent event;
    OnCombobox_format(event);
}


void C_wxMainFrame::init_filepickers(void)
{
    std::vector<wxTextCtrl*> txt_ctrls;

    txt_ctrls.push_back(m_filePicker_app_path_maperitive_gui->GetTextCtrl());
    txt_ctrls.push_back(m_filePicker_app_path_maperitive_con->GetTextCtrl());
    txt_ctrls.push_back(m_filePicker_app_path_imagemagick_convert->GetTextCtrl());
    txt_ctrls.push_back(m_filePicker_app_path_imagemagick_identify->GetTextCtrl());
    txt_ctrls.push_back(m_filePicker_app_path_inkscape->GetTextCtrl());
    txt_ctrls.push_back(m_filePicker_osm_source->GetTextCtrl());

    for (auto el : txt_ctrls)
    {
        el->Enable(false);
    }
}

void C_wxMainFrame::read_settings(void)
{
    //Get the global wxConfigBase instance
    wxConfigBase *conf = wxConfigBase::Get(false);
    if (conf)
    {
        m_filePicker_app_path_maperitive_gui->SetPath(
            check_file_present(conf->Read(wxT("/LastUsedAppPaths/maperitive_gui"), wxT(""))));
        m_filePicker_app_path_maperitive_con->SetPath(
            check_file_present(conf->Read(wxT("/LastUsedAppPaths/maperitive_con"), wxT(""))));
        m_filePicker_app_path_imagemagick_convert->SetPath(
            check_file_present(conf->Read(wxT("/LastUsedAppPaths/imagemagick_convert"), wxT(""))));
        m_filePicker_app_path_imagemagick_identify->SetPath(
            check_file_present(conf->Read(wxT("/LastUsedAppPaths/imagemagick_identify"), wxT(""))));
        m_filePicker_app_path_inkscape->SetPath(
            check_file_present(conf->Read(wxT("/LastUsedAppPaths/inkscape"), wxT(""))));

        m_textCtrl_geometry_bounds->SetValue(
            conf->Read(wxT("/LastUsedMapProperties/geometry_bounds"),
            wxT("")));
        m_filePicker_osm_source->SetPath(
            check_file_present(conf->Read(wxT("/LastUsedMapProperties/osm_source"), wxT(""))));
    }
}

void C_wxMainFrame::write_settings(void)
{
    //Get the global wxConfigBase instance
    wxConfigBase *conf = wxConfigBase::Get(false);
    if (conf)
    {
        conf->Write(wxT("/LastUsedAppPaths/maperitive_gui"),
                    m_filePicker_app_path_maperitive_gui->GetPath());

        conf->Write(wxT("/LastUsedAppPaths/maperitive_con"),
                    m_filePicker_app_path_maperitive_con->GetPath());

        conf->Write(wxT("/LastUsedAppPaths/imagemagick_convert"),
                    m_filePicker_app_path_imagemagick_convert->GetPath());

        conf->Write(wxT("/LastUsedAppPaths/imagemagick_identify"),
                    m_filePicker_app_path_imagemagick_identify->GetPath());

        conf->Write(wxT("/LastUsedAppPaths/inkscape"),
                    m_filePicker_app_path_inkscape->GetPath());


        conf->Write(wxT("/LastUsedMapProperties/geometry_bounds"),
                    m_textCtrl_geometry_bounds->GetValue());

        conf->Write(wxT("/LastUsedMapProperties/osm_source"),
                    m_filePicker_osm_source->GetPath());
    }
}

void C_wxMainFrame::get_inkscape_file_content(void)
{
    get_resource_file(m_inkscape_file_content, L"INKSCAPE");
}

void C_wxMainFrame::shipout_inkscape_file(void)
{
    std::string work_dir = get_current_path();
    write_to_file(m_inkscape_file_content, work_dir + "\\new_card_0.svg");
}

void C_wxMainFrame::update_form_values(void)
{
    m_textCtrl_length->GetValue().ToDouble(&m_length);
    m_textCtrl_height->GetValue().ToDouble(&m_height);
    m_textCtrl_scale->GetValue().ToDouble(&m_scale);
}

void C_wxMainFrame::content_parse(void)
{
    //Read all properties
    read_props(&m_project_file_content);

    //Fill GUI elements according read properties
    m_filePicker_app_path_maperitive_con->SetPath(get_prop_val(MAPC_PATH));
    m_filePicker_app_path_maperitive_gui->SetPath(get_prop_val(MAPG_PATH));
    m_filePicker_app_path_imagemagick_convert->SetPath(get_prop_val(IMCO_PATH));
    m_filePicker_app_path_imagemagick_identify->SetPath(get_prop_val(IMID_PATH));
    m_filePicker_app_path_inkscape->SetPath(get_prop_val(INKS_PATH));

    set_orientation(get_prop_val(CARD_ORIENTATION));
    m_textCtrl_length->SetValue(dot_to_comma(get_prop_val(CARD_PAPERWIDTH_MM)));
    m_textCtrl_height->SetValue(dot_to_comma(get_prop_val(CARD_PAPERHEIGHT_MM)));
    set_format(m_textCtrl_height->GetValue().ToStdString(),
               m_textCtrl_length->GetValue().ToStdString());
    m_textCtrl_center->SetValue(get_prop_val(MAP_CENTER));
    m_textCtrl_scale->SetValue(dot_to_comma(get_prop_val(MAP_SCALE)));
    set_dpi(get_prop_val(MAP_DPI));
    m_checkBox_grid->SetValue( get_prop_val(MAP_USE_GRID) == "true" ? true : false  );
    m_checkBox_attribution->SetValue( get_prop_val(MAP_USE_ATTRIBUTION) == "true" ? true : false );
    m_checkBox_scale->SetValue( get_prop_val(MAP_USE_SCALE) == "true" ? true : false  );

    m_filePicker_osm_source->SetPath(get_prop_val(OSM_PATH));
    m_textCtrl_geometry_bounds->SetValue(get_prop_val(OSM_GEOMETRY_BOUNDS));
}

void C_wxMainFrame::content_serialize(void)
{
    //Take over all properties from GUI elements
    set_prop_val(MAPC_PATH,   m_filePicker_app_path_maperitive_con->GetPath().ToStdString());
    set_prop_val(MAPG_PATH,   m_filePicker_app_path_maperitive_gui->GetPath().ToStdString());
    set_prop_val(IMCO_PATH,   m_filePicker_app_path_imagemagick_convert->GetPath().ToStdString());
    set_prop_val(IMID_PATH,   m_filePicker_app_path_imagemagick_identify->GetPath().ToStdString());
    set_prop_val(INKS_PATH,   m_filePicker_app_path_inkscape->GetPath().ToStdString());

    set_prop_val(CARD_ORIENTATION,    get_orientation());
    set_prop_val(CARD_PAPERWIDTH_MM,  comma_to_dot(m_textCtrl_length->GetValue().ToStdString()));
    set_prop_val(CARD_PAPERHEIGHT_MM, comma_to_dot(m_textCtrl_height->GetValue().ToStdString()));
    set_prop_val(MAP_CENTER,          m_textCtrl_center->GetValue().ToStdString());
    set_prop_val(MAP_SCALE,           comma_to_dot(m_textCtrl_scale->GetValue().ToStdString()));
    set_prop_val(MAP_DPI,             get_dpi());
    set_prop_val(MAP_USE_GRID,        m_checkBox_grid->GetValue()        ? "true" : "false" );
    set_prop_val(MAP_USE_ATTRIBUTION, m_checkBox_attribution->GetValue() ? "true" : "false" );
    set_prop_val(MAP_USE_SCALE,       m_checkBox_scale->GetValue()       ? "true" : "false" );

    set_prop_val(OSM_PATH,            m_filePicker_osm_source->GetPath().ToStdString());
    set_prop_val(OSM_GEOMETRY_BOUNDS, m_textCtrl_geometry_bounds->GetValue().ToStdString());

    //Write all properties
    write_props(&m_project_file_content);
}

void C_wxMainFrame::set_format(std::string height, std::string width)
{
    m_textCtrl_length->Enable(false);
    m_textCtrl_height->Enable(false);

    if ((height == "420,0") && (width == "297,0"))
    {
        m_comboBox_format->SetSelection(1); //DIN-A3
    }
    else if ((height == "297,0") && (width == "210,0"))
    {
        m_comboBox_format->SetSelection(2); //DIN-A4
    }
    else if ((height == "210,0") && (width == "148,0"))
    {
        m_comboBox_format->SetSelection(3); //DIN-A5
    }
    else
    {
        m_comboBox_format->SetSelection(0); //Custom
        m_textCtrl_length->Enable(true);
        m_textCtrl_height->Enable(true);
    }

}

std::string C_wxMainFrame::get_orientation(void)
{
    int sel = m_choice_orientation->GetSelection();

    if (sel == 0)
    {
        return "landscape";
    }

    if (sel == 1)
    {
        return "portrait";
    }

    return "none";
}

void C_wxMainFrame::set_orientation(std::string orientation)
{
    if (orientation == "landscape")
    {
        m_choice_orientation->SetSelection(0);
    }
    if (orientation == "portrait")
    {
        m_choice_orientation->SetSelection(1);
    }
}

std::string C_wxMainFrame::get_dpi(void)
{
    int n = m_choice_dpi->GetSelection();
    return m_choice_dpi->GetString(n).ToStdString();
}

void C_wxMainFrame::set_dpi(std::string dpi)
{
    if (dpi == "96")
        m_choice_dpi->SetSelection(0);

    if (dpi == "150")
        m_choice_dpi->SetSelection(1);

    if (dpi == "300")
        m_choice_dpi->SetSelection(2);

    if (dpi == "600")
        m_choice_dpi->SetSelection(3);

    if (dpi == "1200")
        m_choice_dpi->SetSelection(4);

    if (dpi == "2400")
        m_choice_dpi->SetSelection(5);

    if (dpi == "4800")
        m_choice_dpi->SetSelection(6);
}

wxString C_wxMainFrame::check_file_present(wxString path_file)
{
    if (wxFile::Exists(path_file) == false)
        return "";

    return path_file;
}

void C_wxMainFrame::OnBtnClickStartMapDefBounds( wxCommandEvent& event )
{
    //start script
    std::string cmd = m_filePicker_app_path_maperitive_gui->GetPath().ToStdString();
    bp::spawn(cmd);
}

void C_wxMainFrame::OnText_geometry_bounds( wxCommandEvent& event )
{
    wxString sURL = "";
    sURL += "http://www.overpass-api.de/api/xapi_meta?*[bbox=";
    sURL += m_textCtrl_geometry_bounds->GetValue();
    sURL += "]";

    m_hyperlink_dl_osm_source->SetURL(sURL);
    m_hyperlink_dl_osm_source->SetLabel(sURL);
}

void C_wxMainFrame::OnCombobox_format( wxCommandEvent& event )
{
    wxString Choice = m_comboBox_format->GetValue();

    m_textCtrl_length->Enable(false);
    m_textCtrl_height->Enable(false);

    if (Choice == _("DIN-A5"))
    {
        m_textCtrl_length->SetValue("148,0");
        m_textCtrl_height->SetValue("210,0");
    }
    else if (Choice == _("DIN-A4"))
    {
        m_textCtrl_length->SetValue("210,0");
        m_textCtrl_height->SetValue("297,0");
    }
    else if (Choice == _("DIN-A3"))
    {
        m_textCtrl_length->SetValue("297,0");
        m_textCtrl_height->SetValue("420,0");
    }
    else if (Choice == _("Custom"))
    {
        m_textCtrl_length->Enable(true);
        m_textCtrl_height->Enable(true);
    }

    update_form_values();
}

void C_wxMainFrame::OnButtonClick_fct1( wxCommandEvent& event )
{

    update_form_values();
/*
    get_inkscape_file_content();

    replace_all(m_inkscape_file_content, "210", ftofrmstdstr(m_length)); //width
    replace_all(m_inkscape_file_content, "297", ftofrmstdstr(m_height)); //height

    shipout_inkscape_file();
    test();
*/

    //create *.mscript
    std::string maperitive_script;
    get_resource_file(maperitive_script, L"MAPSCR1");

    //customize script
    replace_all(maperitive_script, "load-source",
                "load-source " + m_filePicker_osm_source->GetPath().ToStdString());
    replace_all(maperitive_script, "height=140.5", "height=" + ftofrmstdstr(m_height));
    replace_all(maperitive_script, "width=210.3",  "width=" + ftofrmstdstr(m_length));
    replace_all(maperitive_script, "orientation=portrait", "orientation=" + get_orientation());

    if (m_textCtrl_center->IsEmpty() == false && m_scale > .0)
    {
        replace_all(maperitive_script, "//set-print-bounds-paper",
                    "set-print-bounds-paper center=" +
                    m_textCtrl_center->GetValue().ToStdString() +
                    " map-scale=" + ftofrmstdstr(m_scale));
    }


    write_to_file(maperitive_script, "W:\\maperitive.mscript");

    //start script
    bp::spawn(m_filePicker_app_path_maperitive_gui->GetPath().ToStdString(),
              "W:\\maperitive.mscript");
}

void C_wxMainFrame::OnButtonClick_create_territory_card( wxCommandEvent& event )
{
    update_form_values();
/*
    content_serialize();
    write_to_file(m_project_file_content, m_project_file);
*/

    //create *.mscript
    std::string maperitive_script;
    get_resource_file(maperitive_script, L"MAPSCR1");
    //customize script
    replace_all(maperitive_script, "load-source",  "load-source " +
                m_filePicker_osm_source->GetPath().ToStdString());
    replace_all(maperitive_script, "height=140.5", "height=" +
                ftofrmstdstr(m_height));
    replace_all(maperitive_script, "width=210.3",  "width=" +
                ftofrmstdstr(m_length));
    replace_all(maperitive_script, "orientation=portrait", "orientation=" +
                get_orientation());
    replace_all(maperitive_script, "set-print-bounds-paper", "");

    maperitive_script += "set-setting name=map.decoration.grid value=" +
        std::string(m_checkBox_grid->GetValue() ? "true" : "false") + sNEWLINE;
    maperitive_script += "set-setting name=map.decoration.attribution value=" +
        std::string(m_checkBox_attribution->GetValue() ? "true" : "false") + sNEWLINE;
    maperitive_script += "set-setting name=map.decoration.scale value=" +
        std::string(m_checkBox_scale->GetValue() ? "true" : "false") + sNEWLINE;

/*
11.7381971080248,51.7940686957109
    ECHO set-setting name=map.decoration.grid value=%UseGrid% >> %DEF_MAP%
ECHO set-setting name=map.decoration.attribution value=%UseAttribution% >> %DEF_MAP%
ECHO set-setting name=map.decoration.scale value=%UseScale% >> %DEF_MAP%
*/


    maperitive_script += "set-print-bounds-paper center=" +
        m_textCtrl_center->GetValue().ToStdString() + sBLANK;
    maperitive_script += "map-scale=" + ftofrmstdstr(m_scale) + sNEWLINE;
    maperitive_script += "export-bitmap file=test.png" + sBLANK + "dpi=" + get_dpi() + sNEWLINE;
    maperitive_script += "set-paper type=A5";
    write_to_file(maperitive_script, "W:\\maperitive.mscript");

    //start script
    bp::spawn(m_filePicker_app_path_maperitive_con->GetPath().ToStdString(),
              "W:\\maperitive.mscript");
}

void C_wxMainFrame::OnFileMenuNew( wxCommandEvent& event )
{
    wxFileDialog
    openFileDialog(this, _("New BAT file"), "", "", "BAT files (*.bat)|*.bat", wxFD_DEFAULT_STYLE);

    int rc = openFileDialog.ShowModal();
    if (rc == wxID_CANCEL)
        return;     // the user changed idea...

    m_project_file = openFileDialog.GetPath().ToStdString();
    m_textCtrl_headline->SetValue(m_project_file);

    get_resource_file(m_project_file_content, L"PRJBATCH");
}

void C_wxMainFrame::OnFileMenuOpen( wxCommandEvent& event )
{
    wxFileDialog
    openFileDialog(this, _("Open BAT file"), "", "", "BAT files (*.bat)|*.bat",
                   wxFD_FILE_MUST_EXIST);

    int rc = openFileDialog.ShowModal();
    if (rc == wxID_CANCEL)
        return;     // the user changed idea...

    m_project_file = openFileDialog.GetPath().ToStdString();
    m_textCtrl_headline->SetValue(m_project_file);

    read_from_file(m_project_file_content, m_project_file);

    content_parse();
}

void C_wxMainFrame::OnFileMenuSave( wxCommandEvent& event )
{
    content_serialize();
    write_to_file(m_project_file_content, m_project_file);
}

void C_wxMainFrame::OnFileMenuSaveAs( wxCommandEvent& event )
{

}

void C_wxMainFrame::OnFileMenuQuit( wxCommandEvent& event )
{
    Close();
}

void C_wxMainFrame::OnHelpMenuAbout( wxCommandEvent& event )
{
    C_wxDlgInfo dlg(this);
    dlg.ShowModal();
}
