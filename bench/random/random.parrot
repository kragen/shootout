.sub main :main
	.param pmc argv
	$S0 = argv[1]
	$I0 = $S0
	load_bytecode "random_lib.pir"
	$P0 = global "gen_random"
while_1:
	$P0(100.0)
	dec $I0
	if $I0 > 1 goto while_1
	$N0 = $P0(100.0)
	$P0 = new .FixedFloatArray
	$P0 = 1
	$P0[0] = $N0
	$S0 = sprintf "%.9f\n", $P0
	print $S0
	.return(0)
.end

.const float IM = 139968.0
.const float IA = 3877.0
.const float IC = 29573.0

.sub gen_random
	.param float max
	.local pmc last
	.include "include/errors.pasm"
	errorson .PARROT_ERRORS_GLOBALS_FLAG
	last = global "last"
	unless last goto lastok
	last = new .Float
	last = 42.0
	global "last" = last
lastok:
	$N0 = last
	$N0 *= IA
	$N0 += IC
	$N0 %= IM
	$N1 = max
	$N1 *= $N0
	$N1 /= IM
	last = $N0
	.return($N1)
.end

