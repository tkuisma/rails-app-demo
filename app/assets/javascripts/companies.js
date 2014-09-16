var companies_table;

function companies_ready() {
    companies_table = init_datatable('#companies-datatable', {'unsortable_columns' : 'last' })
}

$(document).ready(companies_ready);
$(document).on('page:load', companies_ready);
