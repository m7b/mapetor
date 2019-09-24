/***************************************************************
 * Name:      main_app.h
 * Purpose:   Defines Application Class
 * Author:    mbuttig ()
 * Created:   2016-01-21
 * Copyright: mbuttig ()
 * License:
 **************************************************************/

#ifndef MAIN_APP_H
#define MAIN_APP_H

#include <winsock2.h>
#include <wx/app.h>
#include <wx/cmdline.h>
#include <wx/msgdlg.h>
#include <wx/stdpaths.h>      // for wxStandardPaths
#include <wx/fileconf.h>      // for wxFileConfig

#include <iostream>

class Main_App : public wxApp
{
    public:
        virtual bool OnInit();
        virtual int  OnExit();

        virtual void OnInitCmdLine(wxCmdLineParser& parser);
        virtual bool OnCmdLineParsed(wxCmdLineParser& parser);

    private:
		wxLocale *m_locale;
		long m_language;

		void initLanguageSupport(void);
		void initFileConfig(void);
		void deleteFileConfig(void);
};


static const wxCmdLineEntryDesc g_cmdLineDesc [] =
{
     { wxCMD_LINE_SWITCH, "h", "help", _("Displays help on the command line parameters").c_str(),
          wxCMD_LINE_VAL_NONE, wxCMD_LINE_OPTION_HELP },
     { wxCMD_LINE_OPTION, "lang", "language", _("Deviating language of the GUI").c_str(),
          wxCMD_LINE_VAL_STRING,  },
     { wxCMD_LINE_NONE }
};

#endif // MAIN_APP_H
