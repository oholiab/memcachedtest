memcachedtest.rb
================
What is it?
-----------
A quick bit of ruby to have a go at testing the slab reassign features in
memcached 1.4.11+. I wanted to have a go at seeing how it would cope with a semi
production-like distribution of transactions in a number of threads to see
whether the reallocation worked as I expected.

I only had the vaguest idea what I was doing here and just needed a POC.

Why does it eat all the pies?
-----------------------------
I've not rate limited it in any way, it runs in 8 threads, stores ridiculously
sized arrays in memory... That sort of thing. I kept changing my mind about how
it was going to work whilst I was doing it, but it was partly done so that it
would be easy for people to tweak if my numbers were off.

Is it safe to use?
------------------
Beats me, I didn't even do the math to work out if the distribution function
would write in to an array index that I'm not even using.

Dependencies
------------
Dalli for interacting with memcached with minimal fuss and native extension
building.
