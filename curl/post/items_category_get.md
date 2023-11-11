https://catonmat.net/cookbooks/curl/make-post-request
https://reqbin.com/req/c-eanbjsr1/curl-get-xml-example
xmllint --format XML_FILE
    -u "BuscheAlbionWs2@plex.com:6afff48-ba19-"

curl --insecure --location --request POST 'https://api.plexonline.com/DataSource/Service.asmx' \
--header 'SOAPAction: http://www.plexus-online.com/DataSource/ExecuteDataSource' \
--header "Authorization: Basic QnVzY2hlQWxiaW9uV3MyQHBsZXguY29tOjZhZmZmNDgtYmExOS0=" \
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
