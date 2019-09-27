#ifndef __C_wxDlgInfo__
#define __C_wxDlgInfo__

/**
@file
Subclass of InfoDialog, which is generated by wxFormBuilder.
*/

#ifdef _WIN32
#include <winsock2.h>
#endif

#include "C_wxInfoDialog.h"

//// end generated include

#include "version.h"
#include "helpers/helpers.h"
#include <boost/version.hpp>
#include "wxIconBundleResLoader.h"

/** Implementing InfoDialog */
class C_wxDlgInfo : public InfoDialog
{
	public:
		/** Constructor */
		C_wxDlgInfo(wxWindow* parent);
	//// end generated class members

	private:
	    void SetImage(void);
        void CollectComponentVersions(void);
        void SetDescriptionText(void);
        void SetChangelogText(void);
        std::string GetChangelog(void);

        void OnOk(wxCommandEvent &event);
		void OnHtmlLinkClickedChangelog( wxHtmlLinkEvent& event );

};

#endif // __C_wxDlgInfo__
