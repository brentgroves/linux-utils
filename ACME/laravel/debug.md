https://stackoverflow.com/questions/23927561/how-to-debug-laravel-framework

Laravel has its own debugging system.You can use built in dd() function.And there are several packages that can be used to debug laravel projects.Here are some links and hope that it will be helpful for you.

https://github.com/barryvdh/laravel-debugbar

http://laravel.io/forum/02-04-2014-package-laravel-debugbar

Share
Improve this answer
Follow
edited Apr 12, 2022 at 7:43
Muhammad Dyas Yaskur's user avatar
Muhammad Dyas Yaskur
6,4451010 gold badges4747 silver badges7272 bronze badges
answered May 29, 2014 at 8:53
Tanvir's user avatar
Tanvir
1,61522 gold badges1717 silver badges3131 bronze badges
Can you expand your answer a bit more on dd()? When I use it, all I see in the browser is ^ "App\Http\Kernel" – 
dcorking
 Mar 27, 2020 at 16:04
dd(foo) outputs the variable and then ends the script (dump and die). Your browser is showing nothing probably because you are not dumping any data to it. laravel.com/docs/8.x/helpers#method-dd – 
Joey Carlisle
 Nov 9, 2021 at 20:21 