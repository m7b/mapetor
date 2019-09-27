/***************************************************************
 * Name:      Process_image_unravelerApp.cpp
 * Purpose:   Code for Application Class
 * Author:    mbuttig ()
 * Created:   2017-07-24
 * Copyright: mbuttig ()
 * License:
 **************************************************************/

#include "main_app.h"

//(*AppHeaders
#include "gui/C_wxMainFrame.h"
#include <wx/image.h>
//*)


// MyApp member variable:
wxFileConfig *m_fileconfig;

IMPLEMENT_APP(Main_App);

bool Main_App::OnInit()
{

    // call default behaviour (mandatory)
    if (wxApp::OnInit() == false)
    {
        return false;
    }

    initLanguageSupport();
    initFileConfig();

    //(*AppInitialize
    bool wxsOK = true;
    wxInitAllImageHandlers();
    if ( wxsOK )
    {
        C_wxMainFrame* Frame = new C_wxMainFrame(0);
        Frame->Show();
        SetTopWindow(Frame);
    }
    //*)
    return wxsOK;

}

int Main_App::OnExit()
{
    // call default behaviour (mandatory)
    int rc = wxApp::OnInit();
    if (rc == false)
    {
        return rc;
    }

    deleteFileConfig();
    return 0;
}

void Main_App::OnInitCmdLine(wxCmdLineParser& parser)
{
    parser.SetDesc(g_cmdLineDesc);

    // must refuse '/' as parameter starter or cannot use "/path" style paths
    parser.SetSwitchChars (wxT("-"));
}

bool Main_App::OnCmdLineParsed(wxCmdLineParser& parser)
{

    //Sprachumschaltung
    wxString language;
    bool language_found = parser.Found(wxT("lang"), &language);
    if (language_found)
    {
        //todo(mjb): Sprachumschaltung realisieren
        m_language = wxLANGUAGE_UNKNOWN;
#if wxDEBUG_LEVEL == 1
        wxString Foobar;
        Foobar.Printf( wxT("Requested language is: '%s'"), language);
        wxMessageBox(Foobar);
#endif /* wxDEBUG_LEVEL == 1 */
    }
    else
    {
        m_language = wxLANGUAGE_DEFAULT;
    }

    /*
    // to get at your unnamed parameters use
    wxArrayString files;
    for (unsigned int i = 0; i < parser.GetParamCount(); i++)
    {
            files.Add(parser.GetParam(i));
    }
    */

    return true;
}

void Main_App::initLanguageSupport(void)
{
    // load language if possible, fall back to english otherwise
    if (wxLocale::IsAvailable(m_language))
    {
        m_locale = new wxLocale(m_language);

        #ifdef _WIN32
        wxTranslations::Get()->SetLoader(new wxResourceTranslationsLoader);
        #endif
        m_locale->AddCatalog(wxT("mapetor"));

        bool ok = m_locale->IsOk();
        if (ok == false)
        {
            std::cerr << "selected language is wrong" << std::endl;
            delete m_locale;
            m_locale = new wxLocale( wxLANGUAGE_ENGLISH );
            m_language = wxLANGUAGE_ENGLISH;
        }
    }
    else
    {
        std::cout << "The selected language is not supported by your system."
                  << "Try installing support for this language." << std::endl;
        m_locale = new wxLocale( wxLANGUAGE_UNKNOWN );
        m_language = wxLANGUAGE_UNKNOWN;
    }
}

void Main_App::initFileConfig(void)
{
    // create INI file in app directory
    wxFileName executable_file = wxStandardPaths::Get().GetExecutablePath();
    wxString   executable_path = wxString(executable_file.GetPath());
    executable_path += wxFileName::GetPathSeparator();

    m_fileconfig = new wxFileConfig(wxT(""), wxT(""), executable_path+wxT("settings.ini"));

    wxConfigBase::Set(m_fileconfig);
}

void Main_App::deleteFileConfig(void)
{
    if (m_fileconfig)
    {
        m_fileconfig->Flush();      // not really needed
        delete m_fileconfig;
        m_fileconfig=nullptr;
    }

    wxConfigBase::Set(nullptr);
}
