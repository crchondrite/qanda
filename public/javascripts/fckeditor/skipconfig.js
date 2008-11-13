FCKConfig.Plugins.Add( 'autogrow' ) ;
FCKConfig.Plugins.Add( 'dragresizetable' );
FCKConfig.AutoGrowMax = 1000 ;

FCKConfig.DefaultLanguage               = 'ja' ;

FCKConfig.ToolbarSets["Custom"] = [
        ['Source','Preview'],
        ['Cut','Copy','Paste','PasteText','PasteWord'],
        ['Undo','Redo','RemoveFormat'],
        '/',
        ['Bold','Italic','Underline','StrikeThrough'],
        ['OrderedList','UnorderedList','-','Outdent','Indent','Blockquote'],
        ['JustifyLeft','JustifyCenter','JustifyRight','JustifyFull'],
        ['Link','Unlink','Anchor'],
        ['Image','Rule'],
        '/',
        ['Style','FontFormat','FontName','FontSize'],
        ['TextColor','BGColor'],
        ['FitWindow','ShowBlocks','-','About']          // No comma for the last row.
] ;

FCKConfig.FlashBrowser = false ;
FCKConfig.LinkUpload = false ;
FCKConfig.ImageUpload = false ;
FCKConfig.FlashUpload = false ;

