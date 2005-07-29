# The Great Computer Language Shootout
# http://shootout.alioth.debian.org
#
# contributed by Steven Huwig

BEGIN {
    REPLY_SIZE = 64;
    REQUEST_SIZE = 1;
    M = 6400;
    N = ARGV[1];
    if (!client) {
        socket = "/inet/tcp/8000/0/0";
        system("./tcp.awk -v client=1 " N " &");
        while ((socket |& getline) > 0) {
            printf("%"REPLY_SIZE"s", "\n") |& socket;
        }
    } else {
        socket = "/inet/tcp/0/localhost/8000";
        i = N;
        while (i-- > 0) {
            j = M;
            while (j-- > 0) {
                printf("%"REQUEST_SIZE"s", "\n") |& socket;
                socket |& getline var;
                bytes += length(var) + 1; # +1 for implicit \n getline chomp
                replies++;
            }
        }
        print "replies: " replies "   bytes: " bytes;
    }
    close(socket);
}
