https://book-v1.book.kubebuilder.io/beyond_basics/what_is_a_webhook.html
kube-webhook

A callback URL will be invoked by the API method you're calling after it's done. So if you call

POST /api.example.com/foo?callbackURL=http://my.server.com/bar
Then when /foo is finished, it sends a request to http://my.server.com/bar. The contents and method of that request are going to vary - check the documentation for the API you're accessing.

Webhook
Webhooks are HTTP callbacks, providing a way for notifications to be delivered to an external web server. A web application implementing webhooks will send an HTTP request (typically POST) to other application when certain event happens. In the kubernetes world, there are 3 kinds of webhooks: admission webhook, authorization webhook and CRD conversion webhook.

In controller-runtime libraries, currently we only support admission webhooks. CRD conversion webhooks will be supported after it is released in kubernetes 1.12.

Twilio uses HTTP callbacks (webhooks) to let your application know when events happen, such as receiving an SMS message or getting an incoming phone call. When the event occurs, Twilio makes an HTTP request (usually a POST or a GET ) to the URL you configured for the webhook.

