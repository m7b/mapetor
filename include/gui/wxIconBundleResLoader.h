#ifndef WXICONBUNDLE_RESLOADER_H_DEFINED
#define WXICONBUNDLE_RESLOADER_H_DEFINED

#include <wx/wx.h>
#include <wx/iconbndl.h>

/*
For MSW: Loads individual icons with different resolutions stored as ICON resource in the MSW resource file.
If the resource could not be loaded, the returned bundle will be empty.
*/

#ifdef _WIN32
wxIconBundle LoadwxIconBundleFromWindowsResource(const wxString& name, WXHINSTANCE module = 0);
#endif

#endif // #ifndef WXICONBUNDLE_RESLOADER_H_DEFINED
