var best_sellers_table;

function best_sellers_ready() {
    best_sellers_table = init_datatable('#best-sellers-datatable', { 'unsortable_columns' : [0, 5] })
}

$(document).ready(best_sellers_ready);
$(document).on('page:load', best_sellers_ready);
