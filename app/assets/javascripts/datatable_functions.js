function init_datatable(datatable_name, options) {

    if($(datatable_name + '_info').length == 0) {

        // Defaults
        var unsortable_columns  = [];
        var aaSorting           = [];
        var sDom                = "<'row'<'col-md-6'l><'col-md-6'f>r>t<'row'<'col-md-6'i><'col-md-6'p>>";
        var displayLength       = 10;
        var _this = $(datatable_name);
        var load_state          = true;

        if($(window).width() < 500)
            displayLength = 5;

        if(options) {
            if(options['unsortable_columns']) {
                if(options['unsortable_columns'] === 'last') {
                    unsortable_columns = [Number(_this.find('th').length)-1];
                } else if(options['unsortable_columns'] === 'all') {
                    _this.find('th').each(function(index){
                        unsortable_columns.push(index);
                    });
                } else {
                    unsortable_columns = options['unsortable_columns'];
                }
            }

            if(options['aasorting'] == null) {
                aaSorting = [];
            } else {
                aaSorting = options['aasorting'];
            }
        }

        var datatable = _this.dataTable({
            "aLengthMenu"       : [[5, 10, 25, 50, 100], [5, 10, 25, 50, 100]],
            "iDisplayLength"    : displayLength,
            "sDom"              : sDom,
            "aaSorting"         : aaSorting,
            "sPaginationType"   : "bootstrap",
            "bProcessing"       : true,
            "bServerSide"       : true,
            "bStateSave"        : true,
            "sAjaxSource"       : _this.data('source'),
            "aoColumnDefs": [
                { 'bSortable': false, 'aTargets': unsortable_columns }
            ],
            "oLanguage": {
                "sUrl": "/datatables/" + $("#current-language").text() + ".txt"
            },
            "bAutoWidth"          : false
        });
        return datatable;
    }
}
