# Sinatra middleware insert

Test of https://github.com/rapid7/metasploit-framework/pull/12980/files#diff-450c1438fd1939e93afa67f321933d2b44a8b254ad6ce4616d08269588b623e6

For https://github.com/sinatra/sinatra/issues/1659

    rerun -c -- bundle e puma
    clear ; curl -s -v http://localhost:9292
