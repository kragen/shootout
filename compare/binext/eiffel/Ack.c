int Ack(int M, int N) {
    if (M == 0) { return(N + 1); }
    if (N == 0) { return(Ack(M - 1, 1)); }
    return(Ack(M - 1, Ack(M, (N - 1))));
}
