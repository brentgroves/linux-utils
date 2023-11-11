https://www.tothenew.com/blog/dockerizing-nginx-and-ssh-using-supervisord/

https://www.reddit.com/r/kubernetes/comments/k9vnq8/kubernetes_with_supervisord_a_good_pair_or_a_bad/

Running Supervisord inside containers is doable, but it tends to be a bit of an anti-pattern as you have to deal with containers that have a failure in their child processes but not the parent process are not redeployed through the kubernetes scheduler so you are handling those edge cases inside the container which adds complexity. Supervisord covers a few of those cases but often get into the "Supervisord restarted processes until threshold was hit, now it's just borked edge case."

With that being said sometimes you have to break best practices and accept the debt.

We are in the same situation. We deploy several php-laravel applications, in our legacy system we deploy it with nginx, php-fpm, crond (laravel scheduler) and supervisord (laravel queues). In the new kubernetes infrastructure we split every service in an separate container.

At the end, we'll have multiple containers with deployments (nginx, php-fpm, queues), kubernetes cronjobs (scheduler) and kubernetes jobs (some one shot commands).

http://supervisord.org/