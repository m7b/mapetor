///////////////////////////////////////////////////////////////////////////
// C++ code generated with wxFormBuilder (version Jun 13 2019)
// http://www.wxformbuilder.org/
//
// PLEASE DO *NOT* EDIT THIS FILE!
///////////////////////////////////////////////////////////////////////////

#include "C_wxfbMainFrame.h"

///////////////////////////////////////////////////////////////////////////

C_wxfbMainFrame::C_wxfbMainFrame( wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos, const wxSize& size, long style ) : wxFrame( parent, id, title, pos, size, style )
{
	this->SetSizeHints( wxDefaultSize, wxDefaultSize );
	this->SetBackgroundColour( wxSystemSettings::GetColour( wxSYS_COLOUR_MENU ) );

	wxBoxSizer* bSizer_main_frame;
	bSizer_main_frame = new wxBoxSizer( wxVERTICAL );

	m_textCtrl_headline = new wxTextCtrl( this, wxID_ANY, wxEmptyString, wxDefaultPosition, wxDefaultSize, 0 );
	m_textCtrl_headline->Enable( false );

	bSizer_main_frame->Add( m_textCtrl_headline, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxEXPAND|wxLEFT|wxRIGHT|wxTOP, 5 );

	m_notebook3 = new wxNotebook( this, wxID_ANY, wxDefaultPosition, wxDefaultSize, 0 );
	m_notebook3->SetBackgroundColour( wxSystemSettings::GetColour( wxSYS_COLOUR_MENU ) );

	m_scrolledWindow_app_paths = new wxScrolledWindow( m_notebook3, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxHSCROLL|wxVSCROLL );
	m_scrolledWindow_app_paths->SetScrollRate( 5, 5 );
	m_scrolledWindow_app_paths->SetBackgroundColour( wxSystemSettings::GetColour( wxSYS_COLOUR_WINDOW ) );

	wxGridBagSizer* gbSizer_app_paths;
	gbSizer_app_paths = new wxGridBagSizer( 0, 0 );
	gbSizer_app_paths->SetFlexibleDirection( wxBOTH );
	gbSizer_app_paths->SetNonFlexibleGrowMode( wxFLEX_GROWMODE_SPECIFIED );

	m_hyperlink_dl_maperitive = new wxHyperlinkCtrl( m_scrolledWindow_app_paths, wxID_ANY, _("D/L"), wxT("http://lmgtfy.com/?q=Maperitive"), wxDefaultPosition, wxDefaultSize, wxHL_DEFAULT_STYLE );
	gbSizer_app_paths->Add( m_hyperlink_dl_maperitive, wxGBPosition( 0, 0 ), wxGBSpan( 1, 1 ), wxALL|wxALIGN_CENTER_VERTICAL, 5 );

	m_staticText_app_path_maperitive_gui = new wxStaticText( m_scrolledWindow_app_paths, wxID_ANY, _("Maperitive GUI:"), wxDefaultPosition, wxDefaultSize, 0 );
	m_staticText_app_path_maperitive_gui->Wrap( -1 );
	gbSizer_app_paths->Add( m_staticText_app_path_maperitive_gui, wxGBPosition( 1, 1 ), wxGBSpan( 1, 1 ), wxALL|wxALIGN_CENTER_VERTICAL, 5 );

	m_filePicker_app_path_maperitive_con = new wxFilePickerCtrl( m_scrolledWindow_app_paths, wxID_ANY, wxEmptyString, _("Select a file"), _("*.exe"), wxDefaultPosition, wxDefaultSize, wxFLP_DEFAULT_STYLE|wxFLP_SMALL );
	gbSizer_app_paths->Add( m_filePicker_app_path_maperitive_con, wxGBPosition( 0, 2 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALL|wxEXPAND, 5 );

	m_staticText_app_path_maperitive_con = new wxStaticText( m_scrolledWindow_app_paths, wxID_ANY, _("Maperitive Console:"), wxDefaultPosition, wxDefaultSize, 0 );
	m_staticText_app_path_maperitive_con->Wrap( -1 );
	gbSizer_app_paths->Add( m_staticText_app_path_maperitive_con, wxGBPosition( 0, 1 ), wxGBSpan( 1, 1 ), wxALL|wxALIGN_CENTER_VERTICAL, 5 );

	m_filePicker_app_path_maperitive_gui = new wxFilePickerCtrl( m_scrolledWindow_app_paths, wxID_ANY, wxEmptyString, _("Select a file"), _("*.exe"), wxDefaultPosition, wxDefaultSize, wxFLP_DEFAULT_STYLE|wxFLP_SMALL );
	gbSizer_app_paths->Add( m_filePicker_app_path_maperitive_gui, wxGBPosition( 1, 2 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALL|wxEXPAND, 5 );

	m_hyperlink_dl_imagemagick = new wxHyperlinkCtrl( m_scrolledWindow_app_paths, wxID_ANY, _("D/L"), wxT("http://lmgtfy.com/?q=ImageMagick"), wxDefaultPosition, wxDefaultSize, wxHL_DEFAULT_STYLE );
	gbSizer_app_paths->Add( m_hyperlink_dl_imagemagick, wxGBPosition( 2, 0 ), wxGBSpan( 1, 1 ), wxALL|wxALIGN_CENTER_VERTICAL, 5 );

	m_staticText_app_path_imagemagick_convert = new wxStaticText( m_scrolledWindow_app_paths, wxID_ANY, _("ImageMagic convert:"), wxDefaultPosition, wxDefaultSize, 0 );
	m_staticText_app_path_imagemagick_convert->Wrap( -1 );
	gbSizer_app_paths->Add( m_staticText_app_path_imagemagick_convert, wxGBPosition( 2, 1 ), wxGBSpan( 1, 1 ), wxALL|wxALIGN_CENTER_VERTICAL, 5 );

	m_filePicker_app_path_imagemagick_convert = new wxFilePickerCtrl( m_scrolledWindow_app_paths, wxID_ANY, wxEmptyString, _("Select a file"), _("*.exe"), wxDefaultPosition, wxDefaultSize, wxFLP_DEFAULT_STYLE|wxFLP_SMALL );
	gbSizer_app_paths->Add( m_filePicker_app_path_imagemagick_convert, wxGBPosition( 2, 2 ), wxGBSpan( 1, 1 ), wxALL|wxEXPAND|wxALIGN_CENTER_VERTICAL, 5 );

	m_staticText_app_path_imagemagick_identify = new wxStaticText( m_scrolledWindow_app_paths, wxID_ANY, _("ImageMagic identify:"), wxDefaultPosition, wxDefaultSize, 0 );
	m_staticText_app_path_imagemagick_identify->Wrap( -1 );
	gbSizer_app_paths->Add( m_staticText_app_path_imagemagick_identify, wxGBPosition( 3, 1 ), wxGBSpan( 1, 1 ), wxALL|wxALIGN_CENTER_VERTICAL, 5 );

	m_filePicker_app_path_imagemagick_identify = new wxFilePickerCtrl( m_scrolledWindow_app_paths, wxID_ANY, wxEmptyString, _("Select a file"), _("*.exe"), wxDefaultPosition, wxDefaultSize, wxFLP_DEFAULT_STYLE|wxFLP_SMALL );
	gbSizer_app_paths->Add( m_filePicker_app_path_imagemagick_identify, wxGBPosition( 3, 2 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALL|wxEXPAND, 5 );

	m_hyperlink_dl_inkscape = new wxHyperlinkCtrl( m_scrolledWindow_app_paths, wxID_ANY, _("D/L"), wxT("http://lmgtfy.com/?q=Inkscape"), wxDefaultPosition, wxDefaultSize, wxHL_DEFAULT_STYLE );
	gbSizer_app_paths->Add( m_hyperlink_dl_inkscape, wxGBPosition( 4, 0 ), wxGBSpan( 1, 1 ), wxALL|wxALIGN_CENTER_VERTICAL, 5 );

	m_staticText_app_path_inkscape = new wxStaticText( m_scrolledWindow_app_paths, wxID_ANY, _("Inkscape:"), wxDefaultPosition, wxDefaultSize, 0 );
	m_staticText_app_path_inkscape->Wrap( -1 );
	gbSizer_app_paths->Add( m_staticText_app_path_inkscape, wxGBPosition( 4, 1 ), wxGBSpan( 1, 1 ), wxALL|wxALIGN_CENTER_VERTICAL, 5 );

	m_filePicker_app_path_inkscape = new wxFilePickerCtrl( m_scrolledWindow_app_paths, wxID_ANY, wxEmptyString, _("Select a file"), _("*.exe"), wxDefaultPosition, wxDefaultSize, wxFLP_DEFAULT_STYLE|wxFLP_SMALL );
	gbSizer_app_paths->Add( m_filePicker_app_path_inkscape, wxGBPosition( 4, 2 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALL|wxEXPAND, 5 );


	gbSizer_app_paths->AddGrowableCol( 2 );

	m_scrolledWindow_app_paths->SetSizer( gbSizer_app_paths );
	m_scrolledWindow_app_paths->Layout();
	gbSizer_app_paths->Fit( m_scrolledWindow_app_paths );
	m_notebook3->AddPage( m_scrolledWindow_app_paths, _("Application paths"), true );
	m_scrolledWindow_osm_source = new wxScrolledWindow( m_notebook3, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxHSCROLL|wxVSCROLL );
	m_scrolledWindow_osm_source->SetScrollRate( 5, 5 );
	m_scrolledWindow_osm_source->SetBackgroundColour( wxSystemSettings::GetColour( wxSYS_COLOUR_WINDOW ) );

	wxGridBagSizer* gbSizer_osm_source;
	gbSizer_osm_source = new wxGridBagSizer( 0, 0 );
	gbSizer_osm_source->SetFlexibleDirection( wxBOTH );
	gbSizer_osm_source->SetNonFlexibleGrowMode( wxFLEX_GROWMODE_SPECIFIED );

	m_button_start_maperitive_osm_source = new wxButton( m_scrolledWindow_osm_source, wxID_ANY, _("Open Maperitive to specify the geometry bounds of the OSM data to download"), wxDefaultPosition, wxDefaultSize, 0 );
	gbSizer_osm_source->Add( m_button_start_maperitive_osm_source, wxGBPosition( 0, 0 ), wxGBSpan( 1, 2 ), wxALL|wxEXPAND, 5 );

	m_textCtrl_geometry_bounds = new wxTextCtrl( m_scrolledWindow_osm_source, wxID_ANY, wxEmptyString, wxDefaultPosition, wxDefaultSize, 0 );
	gbSizer_osm_source->Add( m_textCtrl_geometry_bounds, wxGBPosition( 1, 1 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALL|wxEXPAND, 5 );

	m_staticText_osm_area = new wxStaticText( m_scrolledWindow_osm_source, wxID_ANY, _("Geometry bounds:"), wxDefaultPosition, wxDefaultSize, 0 );
	m_staticText_osm_area->Wrap( -1 );
	gbSizer_osm_source->Add( m_staticText_osm_area, wxGBPosition( 1, 0 ), wxGBSpan( 1, 1 ), wxALL|wxALIGN_CENTER_VERTICAL, 5 );

	m_button_dl_osm_source = new wxButton( m_scrolledWindow_osm_source, wxID_ANY, _("Download OSM source"), wxDefaultPosition, wxDefaultSize, 0 );
	gbSizer_osm_source->Add( m_button_dl_osm_source, wxGBPosition( 2, 0 ), wxGBSpan( 1, 2 ), wxALL|wxEXPAND, 5 );

	m_hyperlink_dl_osm_source = new wxHyperlinkCtrl( m_scrolledWindow_osm_source, wxID_ANY, wxEmptyString, wxT("www.google.de"), wxDefaultPosition, wxDefaultSize, wxHL_ALIGN_CENTRE|wxHL_DEFAULT_STYLE );
	gbSizer_osm_source->Add( m_hyperlink_dl_osm_source, wxGBPosition( 3, 0 ), wxGBSpan( 1, 2 ), wxALL|wxEXPAND|wxALIGN_CENTER_VERTICAL, 5 );

	m_staticline = new wxStaticLine( m_scrolledWindow_osm_source, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxLI_HORIZONTAL );
	gbSizer_osm_source->Add( m_staticline, wxGBPosition( 4, 0 ), wxGBSpan( 1, 2 ), wxEXPAND|wxALL|wxALIGN_CENTER_VERTICAL, 5 );

	m_filePicker_osm_source = new wxFilePickerCtrl( m_scrolledWindow_osm_source, wxID_ANY, wxEmptyString, _("Select a file"), _("*.osm"), wxDefaultPosition, wxDefaultSize, wxFLP_SMALL|wxFLP_USE_TEXTCTRL );
	gbSizer_osm_source->Add( m_filePicker_osm_source, wxGBPosition( 5, 1 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALL|wxEXPAND, 5 );

	m_staticText_osm_source = new wxStaticText( m_scrolledWindow_osm_source, wxID_ANY, _("OSM source:"), wxDefaultPosition, wxDefaultSize, 0 );
	m_staticText_osm_source->Wrap( -1 );
	gbSizer_osm_source->Add( m_staticText_osm_source, wxGBPosition( 5, 0 ), wxGBSpan( 1, 1 ), wxALL|wxALIGN_CENTER_VERTICAL, 5 );


	gbSizer_osm_source->AddGrowableCol( 1 );

	m_scrolledWindow_osm_source->SetSizer( gbSizer_osm_source );
	m_scrolledWindow_osm_source->Layout();
	gbSizer_osm_source->Fit( m_scrolledWindow_osm_source );
	m_notebook3->AddPage( m_scrolledWindow_osm_source, _("OSM source"), false );
	m_scrolledWindow_main_frame = new wxScrolledWindow( m_notebook3, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxHSCROLL|wxVSCROLL );
	m_scrolledWindow_main_frame->SetScrollRate( 5, 5 );
	m_scrolledWindow_main_frame->SetBackgroundColour( wxSystemSettings::GetColour( wxSYS_COLOUR_WINDOW ) );

	wxGridBagSizer* gbSizer_main_frame;
	gbSizer_main_frame = new wxGridBagSizer( 0, 0 );
	gbSizer_main_frame->SetFlexibleDirection( wxBOTH );
	gbSizer_main_frame->SetNonFlexibleGrowMode( wxFLEX_GROWMODE_SPECIFIED );

	m_staticText_format = new wxStaticText( m_scrolledWindow_main_frame, wxID_ANY, _("Format:"), wxDefaultPosition, wxDefaultSize, 0 );
	m_staticText_format->Wrap( -1 );
	gbSizer_main_frame->Add( m_staticText_format, wxGBPosition( 0, 0 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALIGN_RIGHT|wxALL, 5 );

	m_staticText_length = new wxStaticText( m_scrolledWindow_main_frame, wxID_ANY, _("Width [mm]:"), wxDefaultPosition, wxDefaultSize, wxALIGN_RIGHT );
	m_staticText_length->Wrap( -1 );
	gbSizer_main_frame->Add( m_staticText_length, wxGBPosition( 0, 2 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALIGN_RIGHT|wxALL, 5 );

	m_comboBox_format = new wxComboBox( m_scrolledWindow_main_frame, wxID_ANY, _("DIN-A4"), wxDefaultPosition, wxDefaultSize, 0, NULL, wxCB_READONLY );
	m_comboBox_format->Append( _("Custom") );
	m_comboBox_format->Append( _("DIN-A3") );
	m_comboBox_format->Append( _("DIN-A4") );
	m_comboBox_format->Append( _("DIN-A5") );
	m_comboBox_format->SetSelection( 2 );
	gbSizer_main_frame->Add( m_comboBox_format, wxGBPosition( 0, 1 ), wxGBSpan( 1, 1 ), wxALL|wxALIGN_CENTER_VERTICAL|wxEXPAND, 5 );

	m_textCtrl_length = new wxTextCtrl( m_scrolledWindow_main_frame, wxID_ANY, wxEmptyString, wxDefaultPosition, wxSize( 55,-1 ), wxTE_RIGHT );
	#ifdef __WXGTK__
	if ( !m_textCtrl_length->HasFlag( wxTE_MULTILINE ) )
	{
	m_textCtrl_length->SetMaxLength( 10 );
	}
	#else
	m_textCtrl_length->SetMaxLength( 10 );
	#endif
	gbSizer_main_frame->Add( m_textCtrl_length, wxGBPosition( 0, 3 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALL, 5 );

	m_staticText_height = new wxStaticText( m_scrolledWindow_main_frame, wxID_ANY, _("Height [mm]:"), wxDefaultPosition, wxDefaultSize, wxALIGN_RIGHT );
	m_staticText_height->Wrap( -1 );
	gbSizer_main_frame->Add( m_staticText_height, wxGBPosition( 0, 4 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALIGN_RIGHT|wxALL, 5 );

	m_textCtrl_height = new wxTextCtrl( m_scrolledWindow_main_frame, wxID_ANY, wxEmptyString, wxDefaultPosition, wxSize( 55,-1 ), wxTE_RIGHT );
	#ifdef __WXGTK__
	if ( !m_textCtrl_height->HasFlag( wxTE_MULTILINE ) )
	{
	m_textCtrl_height->SetMaxLength( 10 );
	}
	#else
	m_textCtrl_height->SetMaxLength( 10 );
	#endif
	gbSizer_main_frame->Add( m_textCtrl_height, wxGBPosition( 0, 5 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALL, 5 );

	m_staticText_orientation = new wxStaticText( m_scrolledWindow_main_frame, wxID_ANY, _("Orientation:"), wxDefaultPosition, wxDefaultSize, 0 );
	m_staticText_orientation->Wrap( -1 );
	gbSizer_main_frame->Add( m_staticText_orientation, wxGBPosition( 1, 0 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALIGN_RIGHT|wxALL, 5 );

	wxString m_choice_orientationChoices[] = { _("Landscape"), _("Portrait") };
	int m_choice_orientationNChoices = sizeof( m_choice_orientationChoices ) / sizeof( wxString );
	m_choice_orientation = new wxChoice( m_scrolledWindow_main_frame, wxID_ANY, wxDefaultPosition, wxDefaultSize, m_choice_orientationNChoices, m_choice_orientationChoices, 0 );
	m_choice_orientation->SetSelection( 0 );
	gbSizer_main_frame->Add( m_choice_orientation, wxGBPosition( 1, 1 ), wxGBSpan( 1, 1 ), wxALL|wxALIGN_CENTER_VERTICAL|wxEXPAND, 5 );

	m_staticText_dpi = new wxStaticText( m_scrolledWindow_main_frame, wxID_ANY, _("DPI:"), wxDefaultPosition, wxDefaultSize, 0 );
	m_staticText_dpi->Wrap( -1 );
	gbSizer_main_frame->Add( m_staticText_dpi, wxGBPosition( 1, 2 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALL|wxALIGN_RIGHT, 5 );

	wxString m_choice_dpiChoices[] = { _("96"), _("150"), _("300"), _("600"), _("1200"), _("2400"), _("4800") };
	int m_choice_dpiNChoices = sizeof( m_choice_dpiChoices ) / sizeof( wxString );
	m_choice_dpi = new wxChoice( m_scrolledWindow_main_frame, wxID_ANY, wxDefaultPosition, wxSize( 55,-1 ), m_choice_dpiNChoices, m_choice_dpiChoices, 0 );
	m_choice_dpi->SetSelection( 2 );
	gbSizer_main_frame->Add( m_choice_dpi, wxGBPosition( 1, 3 ), wxGBSpan( 1, 1 ), wxALL, 5 );


	gbSizer_main_frame->AddGrowableCol( 1 );

	m_scrolledWindow_main_frame->SetSizer( gbSizer_main_frame );
	m_scrolledWindow_main_frame->Layout();
	gbSizer_main_frame->Fit( m_scrolledWindow_main_frame );
	m_notebook3->AddPage( m_scrolledWindow_main_frame, _("Map properties"), false );
	m_scrolledWindow_main_frame1 = new wxScrolledWindow( m_notebook3, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxHSCROLL|wxVSCROLL );
	m_scrolledWindow_main_frame1->SetScrollRate( 5, 5 );
	m_scrolledWindow_main_frame1->SetBackgroundColour( wxSystemSettings::GetColour( wxSYS_COLOUR_WINDOW ) );

	wxGridBagSizer* gbSizer_main_frame1;
	gbSizer_main_frame1 = new wxGridBagSizer( 0, 0 );
	gbSizer_main_frame1->SetFlexibleDirection( wxBOTH );
	gbSizer_main_frame1->SetNonFlexibleGrowMode( wxFLEX_GROWMODE_SPECIFIED );

	m_button_fct1 = new wxButton( m_scrolledWindow_main_frame1, wxID_ANY, _("Open Maperitive to specify the card properties"), wxDefaultPosition, wxDefaultSize, 0 );
	gbSizer_main_frame1->Add( m_button_fct1, wxGBPosition( 0, 0 ), wxGBSpan( 1, 5 ), wxALL|wxEXPAND, 5 );

	m_staticText_center = new wxStaticText( m_scrolledWindow_main_frame1, wxID_ANY, _("Center:"), wxDefaultPosition, wxDefaultSize, 0 );
	m_staticText_center->Wrap( -1 );
	gbSizer_main_frame1->Add( m_staticText_center, wxGBPosition( 1, 0 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALIGN_RIGHT|wxALL, 5 );

	m_textCtrl_center = new wxTextCtrl( m_scrolledWindow_main_frame1, wxID_ANY, wxEmptyString, wxDefaultPosition, wxDefaultSize, 0 );
	gbSizer_main_frame1->Add( m_textCtrl_center, wxGBPosition( 1, 1 ), wxGBSpan( 1, 4 ), wxALL|wxEXPAND|wxALIGN_CENTER_VERTICAL, 5 );

	m_staticText_scale = new wxStaticText( m_scrolledWindow_main_frame1, wxID_ANY, _("Scale:"), wxDefaultPosition, wxDefaultSize, 0 );
	m_staticText_scale->Wrap( -1 );
	gbSizer_main_frame1->Add( m_staticText_scale, wxGBPosition( 2, 0 ), wxGBSpan( 1, 1 ), wxALL|wxALIGN_CENTER_VERTICAL|wxALIGN_RIGHT, 5 );

	m_textCtrl_scale = new wxTextCtrl( m_scrolledWindow_main_frame1, wxID_ANY, wxEmptyString, wxDefaultPosition, wxSize( -1,-1 ), 0 );
	gbSizer_main_frame1->Add( m_textCtrl_scale, wxGBPosition( 2, 1 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALL|wxEXPAND, 5 );

	m_checkBox_grid = new wxCheckBox( m_scrolledWindow_main_frame1, wxID_ANY, _("Grid"), wxDefaultPosition, wxDefaultSize, wxALIGN_RIGHT );
	gbSizer_main_frame1->Add( m_checkBox_grid, wxGBPosition( 2, 2 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALL, 5 );

	m_checkBox_attribution = new wxCheckBox( m_scrolledWindow_main_frame1, wxID_ANY, _("Attribution"), wxDefaultPosition, wxDefaultSize, wxALIGN_RIGHT );
	gbSizer_main_frame1->Add( m_checkBox_attribution, wxGBPosition( 2, 3 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALL, 5 );

	m_checkBox_scale = new wxCheckBox( m_scrolledWindow_main_frame1, wxID_ANY, _("Scalebar"), wxDefaultPosition, wxDefaultSize, wxALIGN_RIGHT );
	gbSizer_main_frame1->Add( m_checkBox_scale, wxGBPosition( 2, 4 ), wxGBSpan( 1, 1 ), wxALIGN_CENTER_VERTICAL|wxALL, 5 );

	m_staticText22 = new wxStaticText( m_scrolledWindow_main_frame1, wxID_ANY, _("Rendering Rules (*.mrules):"), wxDefaultPosition, wxDefaultSize, 0 );
	m_staticText22->Wrap( -1 );
	gbSizer_main_frame1->Add( m_staticText22, wxGBPosition( 3, 0 ), wxGBSpan( 1, 1 ), wxALL|wxALIGN_CENTER_VERTICAL, 5 );

	m_filePicker_osm_source1 = new wxFilePickerCtrl( m_scrolledWindow_main_frame1, wxID_ANY, wxEmptyString, _("Select a file"), _("*.mrules"), wxDefaultPosition, wxDefaultSize, wxFLP_SMALL|wxFLP_USE_TEXTCTRL );
	gbSizer_main_frame1->Add( m_filePicker_osm_source1, wxGBPosition( 3, 1 ), wxGBSpan( 1, 5 ), wxALL|wxEXPAND|wxALIGN_CENTER_VERTICAL, 5 );

	wxStaticBoxSizer* sbSizer1;
	sbSizer1 = new wxStaticBoxSizer( new wxStaticBox( m_scrolledWindow_main_frame1, wxID_ANY, _("Preview") ), wxVERTICAL );

	m_bitmap1 = new wxStaticBitmap( sbSizer1->GetStaticBox(), wxID_ANY, wxArtProvider::GetBitmap( wxART_ADD_BOOKMARK, wxART_MENU ), wxDefaultPosition, wxDefaultSize, 0 );
	sbSizer1->Add( m_bitmap1, 1, wxEXPAND, 5 );

	m_button5 = new wxButton( sbSizer1->GetStaticBox(), wxID_ANY, _("Update preview"), wxDefaultPosition, wxDefaultSize, 0 );
	sbSizer1->Add( m_button5, 0, wxEXPAND|wxTOP, 5 );


	gbSizer_main_frame1->Add( sbSizer1, wxGBPosition( 4, 0 ), wxGBSpan( 1, 5 ), wxALL|wxEXPAND, 5 );


	gbSizer_main_frame1->AddGrowableCol( 1 );
	gbSizer_main_frame1->AddGrowableRow( 4 );

	m_scrolledWindow_main_frame1->SetSizer( gbSizer_main_frame1 );
	m_scrolledWindow_main_frame1->Layout();
	gbSizer_main_frame1->Fit( m_scrolledWindow_main_frame1 );
	m_notebook3->AddPage( m_scrolledWindow_main_frame1, _("Map content"), false );
	m_scrolledWindow_main_frame11 = new wxScrolledWindow( m_notebook3, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxHSCROLL|wxVSCROLL );
	m_scrolledWindow_main_frame11->SetScrollRate( 5, 5 );
	m_scrolledWindow_main_frame11->SetBackgroundColour( wxSystemSettings::GetColour( wxSYS_COLOUR_WINDOW ) );

	wxGridBagSizer* gbSizer_main_frame11;
	gbSizer_main_frame11 = new wxGridBagSizer( 0, 0 );
	gbSizer_main_frame11->SetFlexibleDirection( wxBOTH );
	gbSizer_main_frame11->SetNonFlexibleGrowMode( wxFLEX_GROWMODE_SPECIFIED );

	m_button_fct11 = new wxButton( m_scrolledWindow_main_frame11, wxID_ANY, _("Open Inkscape to specify borders and informations"), wxDefaultPosition, wxDefaultSize, 0 );
	gbSizer_main_frame11->Add( m_button_fct11, wxGBPosition( 0, 0 ), wxGBSpan( 1, 2 ), wxALL|wxEXPAND, 5 );

	wxStaticBoxSizer* sbSizer11;
	sbSizer11 = new wxStaticBoxSizer( new wxStaticBox( m_scrolledWindow_main_frame11, wxID_ANY, _("Preview") ), wxVERTICAL );

	m_bitmap11 = new wxStaticBitmap( sbSizer11->GetStaticBox(), wxID_ANY, wxArtProvider::GetBitmap( wxART_ADD_BOOKMARK, wxART_MENU ), wxDefaultPosition, wxDefaultSize, 0 );
	sbSizer11->Add( m_bitmap11, 1, wxEXPAND, 5 );

	m_button51 = new wxButton( sbSizer11->GetStaticBox(), wxID_ANY, _("Update preview"), wxDefaultPosition, wxDefaultSize, 0 );
	sbSizer11->Add( m_button51, 0, wxEXPAND|wxTOP, 5 );


	gbSizer_main_frame11->Add( sbSizer11, wxGBPosition( 2, 0 ), wxGBSpan( 1, 2 ), wxALL|wxEXPAND, 5 );

	m_filePicker_border_file = new wxFilePickerCtrl( m_scrolledWindow_main_frame11, wxID_ANY, wxEmptyString, _("Select a file"), _("*.svg"), wxDefaultPosition, wxDefaultSize, wxFLP_SMALL|wxFLP_USE_TEXTCTRL );
	gbSizer_main_frame11->Add( m_filePicker_border_file, wxGBPosition( 1, 1 ), wxGBSpan( 1, 1 ), wxALL|wxEXPAND|wxALIGN_CENTER_VERTICAL, 5 );

	m_staticText19 = new wxStaticText( m_scrolledWindow_main_frame11, wxID_ANY, _("Border file (*.svg):"), wxDefaultPosition, wxDefaultSize, 0 );
	m_staticText19->Wrap( -1 );
	gbSizer_main_frame11->Add( m_staticText19, wxGBPosition( 1, 0 ), wxGBSpan( 1, 1 ), wxALL|wxALIGN_CENTER_VERTICAL, 5 );


	gbSizer_main_frame11->AddGrowableCol( 1 );
	gbSizer_main_frame11->AddGrowableRow( 2 );

	m_scrolledWindow_main_frame11->SetSizer( gbSizer_main_frame11 );
	m_scrolledWindow_main_frame11->Layout();
	gbSizer_main_frame11->Fit( m_scrolledWindow_main_frame11 );
	m_notebook3->AddPage( m_scrolledWindow_main_frame11, _("Border/Mapinfo"), false );
	m_scrolledWindow_main_frame111 = new wxScrolledWindow( m_notebook3, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxHSCROLL|wxVSCROLL );
	m_scrolledWindow_main_frame111->SetScrollRate( 5, 5 );
	m_scrolledWindow_main_frame111->SetBackgroundColour( wxSystemSettings::GetColour( wxSYS_COLOUR_WINDOW ) );

	wxGridBagSizer* gbSizer_main_frame111;
	gbSizer_main_frame111 = new wxGridBagSizer( 0, 0 );
	gbSizer_main_frame111->SetFlexibleDirection( wxBOTH );
	gbSizer_main_frame111->SetNonFlexibleGrowMode( wxFLEX_GROWMODE_SPECIFIED );

	m_textCtrl11 = new wxTextCtrl( m_scrolledWindow_main_frame111, wxID_ANY, wxEmptyString, wxDefaultPosition, wxDefaultSize, wxTE_LEFT );
	gbSizer_main_frame111->Add( m_textCtrl11, wxGBPosition( 0, 0 ), wxGBSpan( 1, 1 ), wxALL|wxEXPAND, 5 );

	m_textCtrl12 = new wxTextCtrl( m_scrolledWindow_main_frame111, wxID_ANY, wxEmptyString, wxDefaultPosition, wxDefaultSize, wxTE_CENTER );
	gbSizer_main_frame111->Add( m_textCtrl12, wxGBPosition( 0, 1 ), wxGBSpan( 1, 1 ), wxALL|wxEXPAND, 5 );

	m_textCtrl13 = new wxTextCtrl( m_scrolledWindow_main_frame111, wxID_ANY, wxEmptyString, wxDefaultPosition, wxDefaultSize, wxTE_RIGHT );
	gbSizer_main_frame111->Add( m_textCtrl13, wxGBPosition( 0, 2 ), wxGBSpan( 1, 1 ), wxALL|wxEXPAND, 5 );

	wxStaticBoxSizer* sbSizer111;
	sbSizer111 = new wxStaticBoxSizer( new wxStaticBox( m_scrolledWindow_main_frame111, wxID_ANY, _("Preview") ), wxVERTICAL );

	m_bitmap111 = new wxStaticBitmap( sbSizer111->GetStaticBox(), wxID_ANY, wxArtProvider::GetBitmap( wxART_ADD_BOOKMARK, wxART_MENU ), wxDefaultPosition, wxDefaultSize, 0 );
	sbSizer111->Add( m_bitmap111, 1, wxEXPAND, 5 );

	m_button511 = new wxButton( sbSizer111->GetStaticBox(), wxID_ANY, _("Update preview"), wxDefaultPosition, wxDefaultSize, 0 );
	sbSizer111->Add( m_button511, 0, wxEXPAND|wxTOP, 5 );


	gbSizer_main_frame111->Add( sbSizer111, wxGBPosition( 1, 0 ), wxGBSpan( 1, 3 ), wxEXPAND|wxLEFT|wxRIGHT, 5 );

	m_textCtrl14 = new wxTextCtrl( m_scrolledWindow_main_frame111, wxID_ANY, wxEmptyString, wxDefaultPosition, wxDefaultSize, wxTE_CENTER );
	gbSizer_main_frame111->Add( m_textCtrl14, wxGBPosition( 2, 0 ), wxGBSpan( 1, 3 ), wxALL|wxEXPAND, 5 );

	m_checkBox10 = new wxCheckBox( m_scrolledWindow_main_frame111, wxID_ANY, _("OSM Contribution"), wxDefaultPosition, wxDefaultSize, 0 );
	m_checkBox10->SetValue(true);
	gbSizer_main_frame111->Add( m_checkBox10, wxGBPosition( 1, 3 ), wxGBSpan( 1, 1 ), wxALL|wxALIGN_CENTER_VERTICAL, 5 );


	gbSizer_main_frame111->AddGrowableCol( 0 );
	gbSizer_main_frame111->AddGrowableCol( 1 );
	gbSizer_main_frame111->AddGrowableCol( 2 );
	gbSizer_main_frame111->AddGrowableRow( 1 );

	m_scrolledWindow_main_frame111->SetSizer( gbSizer_main_frame111 );
	m_scrolledWindow_main_frame111->Layout();
	gbSizer_main_frame111->Fit( m_scrolledWindow_main_frame111 );
	m_notebook3->AddPage( m_scrolledWindow_main_frame111, _("Final overlay"), false );

	bSizer_main_frame->Add( m_notebook3, 1, wxALL|wxEXPAND|wxALIGN_CENTER_HORIZONTAL, 5 );

	m_button_create_territory_card = new wxButton( this, wxID_ANY, _("Create territory card"), wxDefaultPosition, wxDefaultSize, 0 );
	bSizer_main_frame->Add( m_button_create_territory_card, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxBOTTOM|wxEXPAND|wxLEFT|wxRIGHT, 5 );


	this->SetSizer( bSizer_main_frame );
	this->Layout();
	m_menubar = new wxMenuBar( 0 );
	m_menu_file = new wxMenu();
	wxMenuItem* m_menu_file_new;
	m_menu_file_new = new wxMenuItem( m_menu_file, wxID_ANY, wxString( _("New Project...") ) + wxT('\t') + wxT("Ctrl+N"), wxEmptyString, wxITEM_NORMAL );
	#ifdef __WXMSW__
	m_menu_file_new->SetBitmaps( wxArtProvider::GetBitmap( wxART_NEW, wxART_MENU ) );
	#elif (defined( __WXGTK__ ) || defined( __WXOSX__ ))
	m_menu_file_new->SetBitmap( wxArtProvider::GetBitmap( wxART_NEW, wxART_MENU ) );
	#endif
	m_menu_file->Append( m_menu_file_new );

	wxMenuItem* m_menu_file_open;
	m_menu_file_open = new wxMenuItem( m_menu_file, ID_OPEN, wxString( _("Open...") ) + wxT('\t') + wxT("Ctrl+O"), wxEmptyString, wxITEM_NORMAL );
	#ifdef __WXMSW__
	m_menu_file_open->SetBitmaps( wxArtProvider::GetBitmap( wxART_FILE_OPEN, wxART_MENU ) );
	#elif (defined( __WXGTK__ ) || defined( __WXOSX__ ))
	m_menu_file_open->SetBitmap( wxArtProvider::GetBitmap( wxART_FILE_OPEN, wxART_MENU ) );
	#endif
	m_menu_file->Append( m_menu_file_open );

	m_menu_file->AppendSeparator();

	wxMenuItem* m_menuItem_file_save;
	m_menuItem_file_save = new wxMenuItem( m_menu_file, wxID_ANY, wxString( _("Save") ) + wxT('\t') + wxT("Ctrl+S"), wxEmptyString, wxITEM_NORMAL );
	#ifdef __WXMSW__
	m_menuItem_file_save->SetBitmaps( wxArtProvider::GetBitmap( wxART_FILE_SAVE, wxART_MENU ) );
	#elif (defined( __WXGTK__ ) || defined( __WXOSX__ ))
	m_menuItem_file_save->SetBitmap( wxArtProvider::GetBitmap( wxART_FILE_SAVE, wxART_MENU ) );
	#endif
	m_menu_file->Append( m_menuItem_file_save );

	wxMenuItem* m_menuItemfile_save_as;
	m_menuItemfile_save_as = new wxMenuItem( m_menu_file, wxID_ANY, wxString( _("Save As...") ) + wxT('\t') + wxT("Ctrl+Shift+S"), wxEmptyString, wxITEM_NORMAL );
	#ifdef __WXMSW__
	m_menuItemfile_save_as->SetBitmaps( wxArtProvider::GetBitmap( wxART_FILE_SAVE_AS, wxART_MENU ) );
	#elif (defined( __WXGTK__ ) || defined( __WXOSX__ ))
	m_menuItemfile_save_as->SetBitmap( wxArtProvider::GetBitmap( wxART_FILE_SAVE_AS, wxART_MENU ) );
	#endif
	m_menu_file->Append( m_menuItemfile_save_as );

	m_menu_file->AppendSeparator();

	wxMenuItem* m_file_menu_quit;
	m_file_menu_quit = new wxMenuItem( m_menu_file, ID_QUIT, wxString( _("Quit") ) + wxT('\t') + wxT("Ctrl+Q"), wxEmptyString, wxITEM_NORMAL );
	#ifdef __WXMSW__
	m_file_menu_quit->SetBitmaps( wxArtProvider::GetBitmap( wxART_QUIT, wxART_MENU ) );
	#elif (defined( __WXGTK__ ) || defined( __WXOSX__ ))
	m_file_menu_quit->SetBitmap( wxArtProvider::GetBitmap( wxART_QUIT, wxART_MENU ) );
	#endif
	m_menu_file->Append( m_file_menu_quit );

	m_menubar->Append( m_menu_file, _("&File") );

	m_menu_help = new wxMenu();
	wxMenuItem* m_help_menu_about;
	m_help_menu_about = new wxMenuItem( m_menu_help, ID_ABOUT, wxString( _("About...") ) + wxT('\t') + wxT("F1"), wxEmptyString, wxITEM_NORMAL );
	#ifdef __WXMSW__
	m_help_menu_about->SetBitmaps( wxArtProvider::GetBitmap( wxART_HELP, wxART_MENU ) );
	#elif (defined( __WXGTK__ ) || defined( __WXOSX__ ))
	m_help_menu_about->SetBitmap( wxArtProvider::GetBitmap( wxART_HELP, wxART_MENU ) );
	#endif
	m_menu_help->Append( m_help_menu_about );

	m_menubar->Append( m_menu_help, _("&Help") );

	this->SetMenuBar( m_menubar );


	this->Centre( wxBOTH );

	// Connect Events
	m_button_start_maperitive_osm_source->Connect( wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler( C_wxfbMainFrame::OnBtnClickStartMapDefBounds ), NULL, this );
	m_textCtrl_geometry_bounds->Connect( wxEVT_COMMAND_TEXT_UPDATED, wxCommandEventHandler( C_wxfbMainFrame::OnText_geometry_bounds ), NULL, this );
	m_comboBox_format->Connect( wxEVT_COMMAND_COMBOBOX_SELECTED, wxCommandEventHandler( C_wxfbMainFrame::OnCombobox_format ), NULL, this );
	m_button_fct1->Connect( wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler( C_wxfbMainFrame::OnButtonClick_fct1 ), NULL, this );
	m_button_fct11->Connect( wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler( C_wxfbMainFrame::OnButtonClick_fct1 ), NULL, this );
	m_button_create_territory_card->Connect( wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler( C_wxfbMainFrame::OnButtonClick_create_territory_card ), NULL, this );
	m_menu_file->Bind(wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler( C_wxfbMainFrame::OnFileMenuNew ), this, m_menu_file_new->GetId());
	m_menu_file->Bind(wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler( C_wxfbMainFrame::OnFileMenuOpen ), this, m_menu_file_open->GetId());
	m_menu_file->Bind(wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler( C_wxfbMainFrame::OnFileMenuSave ), this, m_menuItem_file_save->GetId());
	m_menu_file->Bind(wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler( C_wxfbMainFrame::OnFileMenuSaveAs ), this, m_menuItemfile_save_as->GetId());
	m_menu_file->Bind(wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler( C_wxfbMainFrame::OnFileMenuQuit ), this, m_file_menu_quit->GetId());
	m_menu_help->Bind(wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler( C_wxfbMainFrame::OnHelpMenuAbout ), this, m_help_menu_about->GetId());
}

C_wxfbMainFrame::~C_wxfbMainFrame()
{
	// Disconnect Events
	m_button_start_maperitive_osm_source->Disconnect( wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler( C_wxfbMainFrame::OnBtnClickStartMapDefBounds ), NULL, this );
	m_textCtrl_geometry_bounds->Disconnect( wxEVT_COMMAND_TEXT_UPDATED, wxCommandEventHandler( C_wxfbMainFrame::OnText_geometry_bounds ), NULL, this );
	m_comboBox_format->Disconnect( wxEVT_COMMAND_COMBOBOX_SELECTED, wxCommandEventHandler( C_wxfbMainFrame::OnCombobox_format ), NULL, this );
	m_button_fct1->Disconnect( wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler( C_wxfbMainFrame::OnButtonClick_fct1 ), NULL, this );
	m_button_fct11->Disconnect( wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler( C_wxfbMainFrame::OnButtonClick_fct1 ), NULL, this );
	m_button_create_territory_card->Disconnect( wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler( C_wxfbMainFrame::OnButtonClick_create_territory_card ), NULL, this );

}
