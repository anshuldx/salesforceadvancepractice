public with sharing class AnalyticsController{

    public List<SelectOption> availableReports { get; set; }
    public Id reportId { get; set; }
    public Map<String, List<SelectOption>> availableDataTypeFilterOperators { get; set; }
    public List<ColumnFilter> availableColumnFilters { get; set; }

    public AnalyticsController() {
        availableReports = retrieveAvailableReports();
        availableDataTypeFilterOperators = retrieveAvailableDataTypeFilterOperators();
    }

    public List<SelectOption> retrieveAvailableReports() {
        List<SelectOption> reptOpts = new List<SelectOption>();
        for (Report r : [
             Select Id, Name
             From Report
             Where Format In ('Summary','Matrix')
             Order By Name
        ]) {
            reptOpts.add(new SelectOption(r.Id, r.Name));
        }
        return reptOpts;
    }

    public Map<String, List<SelectOption>> retrieveAvailableDataTypeFilterOperators() {
        Map<String, List<SelectOption>> dataTypeFilterOpts = new Map<String, List<SelectOption>>();
        Map<String, List<Reports.FilterOperator>> filterOperatorMap = Reports.ReportManager.getDataTypeFilterOperatorMap();

        for (String dataType : filterOperatorMap.keySet()) {
            List<SelectOption> operators = new List<SelectOption>();

            // Append _DATA to match ColumnDataType from ReportTypeColumn
            dataTypeFilterOpts.put(dataType.toUpperCase() + '_DATA', operators);

            for (Reports.FilterOperator fo : filterOperatorMap.get(dataType)) {
                operators.add(new SelectOption(fo.getName(), fo.getLabel()));
            }
        }        
        return dataTypeFilterOpts;
    }

    public PageReference getReportInfo() {
        Reports.ReportDescribeResult descRes = Reports.ReportManager.describeReport(reportId);

        availableColumnFilters = new List<ColumnFilter>();

        for (Reports.ReportTypeColumnCategory category : descRes.getReportTypeMetadata().getCategories()) {
            for (Reports.ReportTypeColumn col : category.getColumns().values()) {
                System.debug('$$$Enter into record type$$$$');
                if (col.getFilterable()) {
                    ColumnFilter cf = new ColumnFilter(
                        col.getLabel(),
                        col.getName(),
                        col.getDataType().name()
                    );
                    if(col.getLabel()=='Close Date'){
                        System.debug('###column label:'+ col.getLabel()+'#####column name:'+col.getName()+'####data type name:'+col.getDataType().name());
                        availableColumnFilters.add(cf);
                    }
                }
            }
        }
        return null;
    }

    public String getChartFilter() {
        //System.debug('%%%%%%%'+JSON.serialize(getSelectedFilters()));
        //String json='[{column:'CLOSE_DATE',operator:'equals',value:'10-06-2013'}]';
        //return JSON.serialize(getSelectedFilters());
        //return json;
        // Create a JSONGenerator object.Pass true to the constructor for pretty print formatting.
                JSONGenerator gen = JSON.createGenerator(true);
                // Write data to the JSON string.
                gen.writeStartObject();
                gen.writeStringField('column', 'CLOSE_DATE'); 
                gen.writeStringField('operator', 'equals'); 
                gen.writeStringField('value', '2014-06-10'); 
                gen.writeEndObject();

                // Get the JSON string.
                String JsonString= gen.getAsString();
                JsonString=JsonString.replace('{','[{');
                JsonString=JsonString.replace('}','}]');
                System.debug('####'+JsonString);
                return JsonString;
    
    }

    private List<ColumnFilter> getSelectedFilters() {
        List<ColumnFilter> selectedFilters = new List<ColumnFilter>();
        for (ColumnFilter cf : availableColumnFilters) {
            System.debug('@@@@@'+cf.column);
            if (String.isNotBlank(cf.operator)) {
                
                selectedFilters.add(cf);
            }
        }
        return selectedFilters;
    }

    public class ColumnFilter {
        public ColumnFilter(String lab, String col, String dt) {
            label = lab;
            column = col;
            dataType = dt;
        }

        // Values needed for apex:analytics component
        public String column { get; set; }
        public String operator { get; set; }
        public String value { get; set; }

        // Values need for display and operator select list
        public String label { get; set; }
        public String dataType { get; set; }

    }
}