/**
* @author DevName
* @date 12/12/2016
*
* @group PROJECT name
*
* @description Description of the project
*/
@RestResource(urlMapping='/api/CloseOpportunity')
global with sharing class CloseOpportunity
{
    @HttpPost
    global static void doPost( ) 
    {
        RestRequest req = RestContext.request;

        RestResponse standardResp = RestContext.response;

        OpportunityIdWrapper reqBodyObj;

        try {
            String requestBody = req.requestBody.toString();
            reqBodyObj = (OpportunityIdWrapper) JSON.deserialize(requestBody, OpportunityIdWrapper.class);
        } catch (Exception ex) {
            return ;
        }
        System.debug('--------TestFEFE------->'+reqBodyObj);
        
        List<Opportunity> lstOpp;
        if(reqBodyObj.Id!= null){
        	try {
            		lstOpp = [select id from Opportunity where name =:reqBodyObj.Id];
            	} catch (Exception ex) {
            		return ;
        		  } 
        }
        
        if(lstOpp.size() >0 ){
            Opportunity oppObj = lstOpp.get(0);
            oppObj.CloseDate=  System.today();
            try{
            	UPDATE oppObj;
            } catch (Exception ex) {
            	return ;
        	}
        }
    }
    
/**
* @author DevName
* @date 12/12/2016
*
* @group PROJECT name
*
* @description Description of the project
*/
     public class OpportunityIdWrapper {
        public String Id;
     }

}