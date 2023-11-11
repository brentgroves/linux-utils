https://reqbin.com/req/c-haxm0xgr/curl-basic-auth-example

Sending Curl Request with Basic Authentication Credentials
To send basic auth credentials with Curl, use the "-u login: password" command-line option. Curl automatically converts the login: password pair into a Base64-encoded string and adds the "Authorization: Basic [token]" header to the request. In this Curl request with Basic Auth Credentials example, we send a request with basic authorization credentials to the ReqBin echo URL. Click Run to execute the Curl Basic Authentication Credentials Example online and see the results.
Sending Curl Request with Basic Authentication Credentials
Run
curl https://reqbin.com/echo
   -u "login:password"

Curl syntax to make a Plex web service call:
curl --insecure --location --request POST 'https://api.plexonline.com/DataSource/Service.asmx' \
--header 'SOAPAction: http://www.plexus-online.com/DataSource/ExecuteDataSource' \
--header "Authorization: Ask me for this line" \
--header 'Content-Type: text/xml; charset=utf-8' \
--data-raw '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:dat="http://www.plexus-online.com/DataSource">  <soapenv:Header/>
   <soapenv:Body>
      <dat:ExecuteDataSource>
         <!--Optional:-->
         <dat:ExecuteDataSourceRequest>
            <!--Optional:-->
            <dat:DataSourceKey>2912</dat:DataSourceKey>
            <!--Optional:-->
            <dat:InputParameters>
               <!--Zero or more repetitions:-->
             </dat:InputParameters>
            <!--Optional:-->
            <dat:DataSourceName>?</dat:DataSourceName>
            <!--Optional:-->
            <dat:DataBase>?</dat:DataBase>
         </dat:ExecuteDataSourceRequest>
      </dat:ExecuteDataSource>
   </soapenv:Body>
</soapenv:Envelope>' | xmllint --format - > result.xml
Notes: 
1. xmllint just puts the output in a nice format so everything from the pipe | onward can be ommitted.
2. the authorization line is 'Authorization: Basic ' plus the base64 encoded version of our username:password include the colon.
