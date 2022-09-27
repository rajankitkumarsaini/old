@RestResource(urlmapping='/helloworld/*')
global with sharing class HelloWorldWebService {
    @HttpGet
    global static string helloworld(){
        return 'HelloWorld';
    }

}