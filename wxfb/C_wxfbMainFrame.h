///////////////////////////////////////////////////////////////////////////
// C++ code generated with wxFormBuilder (version Jun 13 2019)
// http://www.wxformbuilder.org/
//
// PLEASE DO *NOT* EDIT THIS FILE!
///////////////////////////////////////////////////////////////////////////

#pragma once

#include <wx/artprov.h>
#include <wx/xrc/xmlres.h>
#include <wx/intl.h>
#include <wx/string.h>
#include <wx/textctrl.h>
#include <wx/gdicmn.h>
#include <wx/font.h>
#include <wx/colour.h>
#include <wx/settings.h>
#include <wx/hyperlink.h>
#include <wx/stattext.h>
#include <wx/filepicker.h>
#include <wx/gbsizer.h>
#include <wx/scrolwin.h>
#include <wx/bitmap.h>
#include <wx/image.h>
#include <wx/icon.h>
#include <wx/button.h>
#include <wx/statline.h>
#include <wx/combobox.h>
#include <wx/valtext.h>
#include <wx/choice.h>
#include <wx/checkbox.h>
#include <wx/statbmp.h>
#include <wx/sizer.h>
#include <wx/statbox.h>
#include <wx/notebook.h>
#include <wx/menu.h>
#include <wx/frame.h>

///////////////////////////////////////////////////////////////////////////

#define ID_OPEN 1000
#define ID_QUIT 1001
#define ID_ABOUT 1002

///////////////////////////////////////////////////////////////////////////////
/// Class C_wxfbMainFrame
///////////////////////////////////////////////////////////////////////////////
class C_wxfbMainFrame : public wxFrame
{
	private:

	protected:
		wxTextCtrl* m_textCtrl_headline;
		wxNotebook* m_notebook3;
		wxScrolledWindow* m_scrolledWindow_app_paths;
		wxHyperlinkCtrl* m_hyperlink_dl_maperitive;
		wxStaticText* m_staticText_app_path_maperitive_gui;
		wxFilePickerCtrl* m_filePicker_app_path_maperitive_con;
		wxStaticText* m_staticText_app_path_maperitive_con;
		wxFilePickerCtrl* m_filePicker_app_path_maperitive_gui;
		wxHyperlinkCtrl* m_hyperlink_dl_imagemagick;
		wxStaticText* m_staticText_app_path_imagemagick_convert;
		wxFilePickerCtrl* m_filePicker_app_path_imagemagick_convert;
		wxStaticText* m_staticText_app_path_imagemagick_identify;
		wxFilePickerCtrl* m_filePicker_app_path_imagemagick_identify;
		wxHyperlinkCtrl* m_hyperlink_dl_inkscape;
		wxStaticText* m_staticText_app_path_inkscape;
		wxFilePickerCtrl* m_filePicker_app_path_inkscape;
		wxScrolledWindow* m_scrolledWindow_osm_source;
		wxButton* m_button_start_maperitive_osm_source;
		wxTextCtrl* m_textCtrl_geometry_bounds;
		wxStaticText* m_staticText_osm_area;
		wxButton* m_button_dl_osm_source;
		wxHyperlinkCtrl* m_hyperlink_dl_osm_source;
		wxStaticLine* m_staticline;
		wxFilePickerCtrl* m_filePicker_osm_source;
		wxStaticText* m_staticText_osm_source;
		wxScrolledWindow* m_scrolledWindow_main_frame;
		wxStaticText* m_staticText_format;
		wxStaticText* m_staticText_length;
		wxComboBox* m_comboBox_format;
		wxTextCtrl* m_textCtrl_length;
		wxStaticText* m_staticText_height;
		wxTextCtrl* m_textCtrl_height;
		wxStaticText* m_staticText_orientation;
		wxChoice* m_choice_orientation;
		wxStaticText* m_staticText_dpi;
		wxChoice* m_choice_dpi;
		wxScrolledWindow* m_scrolledWindow_main_frame1;
		wxButton* m_button_fct1;
		wxStaticText* m_staticText_center;
		wxTextCtrl* m_textCtrl_center;
		wxStaticText* m_staticText_scale;
		wxTextCtrl* m_textCtrl_scale;
		wxCheckBox* m_checkBox_grid;
		wxCheckBox* m_checkBox_attribution;
		wxCheckBox* m_checkBox_scale;
		wxStaticText* m_staticText22;
		wxFilePickerCtrl* m_filePicker_osm_source1;
		wxStaticBitmap* m_bitmap1;
		wxButton* m_button5;
		wxScrolledWindow* m_scrolledWindow_main_frame11;
		wxButton* m_button_fct11;
		wxStaticBitmap* m_bitmap11;
		wxButton* m_button51;
		wxFilePickerCtrl* m_filePicker_border_file;
		wxStaticText* m_staticText19;
		wxScrolledWindow* m_scrolledWindow_main_frame111;
		wxTextCtrl* m_textCtrl11;
		wxTextCtrl* m_textCtrl12;
		wxTextCtrl* m_textCtrl13;
		wxStaticBitmap* m_bitmap111;
		wxButton* m_button511;
		wxTextCtrl* m_textCtrl14;
		wxCheckBox* m_checkBox10;
		wxButton* m_button_create_territory_card;
		wxMenuBar* m_menubar;
		wxMenu* m_menu_file;
		wxMenu* m_menu_help;

		// Virtual event handlers, overide them in your derived class
		virtual void OnBtnClickStartMapDefBounds( wxCommandEvent& event ) { event.Skip(); }
		virtual void OnText_geometry_bounds( wxCommandEvent& event ) { event.Skip(); }
		virtual void OnCombobox_format( wxCommandEvent& event ) { event.Skip(); }
		virtual void OnButtonClick_fct1( wxCommandEvent& event ) { event.Skip(); }
		virtual void OnButtonClick_create_territory_card( wxCommandEvent& event ) { event.Skip(); }
		virtual void OnFileMenuNew( wxCommandEvent& event ) { event.Skip(); }
		virtual void OnFileMenuOpen( wxCommandEvent& event ) { event.Skip(); }
		virtual void OnFileMenuSave( wxCommandEvent& event ) { event.Skip(); }
		virtual void OnFileMenuSaveAs( wxCommandEvent& event ) { event.Skip(); }
		virtual void OnFileMenuQuit( wxCommandEvent& event ) { event.Skip(); }
		virtual void OnHelpMenuAbout( wxCommandEvent& event ) { event.Skip(); }


	public:

		C_wxfbMainFrame( wxWindow* parent, wxWindowID id = wxID_ANY, const wxString& title = wxEmptyString, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxSize( 570,420 ), long style = wxDEFAULT_FRAME_STYLE|wxTAB_TRAVERSAL );

		~C_wxfbMainFrame();

};

