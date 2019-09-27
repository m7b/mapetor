#include "gui/C_wxDlgInfo.h"


//helper functions
enum wxbuildinfoformat {short_f, long_f};

wxString wxbuildinfo(wxbuildinfoformat format)
{
    wxString wxbuild(wxVERSION_STRING);

    if (format == long_f )
    {
#if defined(__WXMSW__)
        wxbuild << _T("-Windows");
#elif defined(__UNIX__)
        wxbuild << _T("-Linux");
#endif

#if wxUSE_UNICODE
        wxbuild << _T("-Unicode build");
#else
        wxbuild << _T("-ANSI build");
#endif // wxUSE_UNICODE
    }

    return wxbuild;
}


C_wxDlgInfo::C_wxDlgInfo(wxWindow* parent)
    :
    InfoDialog( parent )
{
    #ifdef _WIN32
        SetIcon(wxICON(MAINICON));
        SetImage();
    #endif

    m_staticTextName->SetLabel(VER_PRODUCTNAME_STR);
    m_staticTextFileVersion->SetLabel(wxString::Format("v%s", VER_FILE_VERSION_STR));
    m_staticTextFileDescription->SetLabel(wxString::Format(_("Build: %s from rev. %s"),
                                          STRINGIZE(SVN_TIME_NOW),
                                          STRINGIZE(SVN_REVISION)));

    m_staticTextAuthor->SetLabel(wxString::Format(_("Author: %s"), AUTHOR));

    CollectComponentVersions();
    SetDescriptionText();
    SetChangelogText();
}


void C_wxDlgInfo::SetImage(void)
{
    wxIconBundle bundle = LoadwxIconBundleFromWindowsResource("MAINICON");
    unsigned int ico_to_show = 2;
    if (bundle.GetIconCount() >= ico_to_show)
    {
        m_bitmap->SetIcon(bundle.GetIconByIndex(ico_to_show));
    }
    else
    {
        m_bitmap->SetIcon(wxICON(MAINICON));
    }
}


void C_wxDlgInfo::CollectComponentVersions(void)
{
    wxString tmp;

    tmp += "GCC " + wxString(__VERSION__) + "\n";
    tmp += wxbuildinfo(long_f) + "\n";
    tmp += "Boost " + wxString::Format("%d.%d.%d",
                                       BOOST_VERSION / 100000,
                                       BOOST_VERSION / 100 % 1000,
                                       BOOST_VERSION % 100) + "\n";

    m_richTextInfo->SetValue(tmp);
}

void C_wxDlgInfo::SetDescriptionText(void)
{
    wxString tmp;

    tmp += _("Creates custom layered maps.");

    m_richTextDescription->SetValue(tmp);
}

void C_wxDlgInfo::SetChangelogText(void)
{
    m_htmlWinChangelog->SetStandardFonts(8);
    m_htmlWinChangelog->SetPage(GetChangelog());
}

std::string C_wxDlgInfo::GetChangelog(void)
{
    std::string changelog;
    #ifdef _WIN32
        get_resource_file(changelog, L"CHANGELOG");
    #endif
    return changelog;
}

void C_wxDlgInfo::OnOk(wxCommandEvent &event)
{
    Close();
}

void C_wxDlgInfo::OnHtmlLinkClickedChangelog( wxHtmlLinkEvent& event )
{
    wxHtmlLinkInfo LinkInfo = event.GetLinkInfo();
    wxLaunchDefaultBrowser(LinkInfo.GetHref());
}
