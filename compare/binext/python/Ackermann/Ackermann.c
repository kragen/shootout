#include <Python.h>

/* forward declaration for Ack function */
static PyObject *Ack(PyObject *self, PyObject *args);

/* create entry for Ack function in module method table */
static PyMethodDef AckermannMethods[] = {
    {"Ack", Ack, METH_VARARGS},
    {NULL, NULL}        /* Sentinel */
};

/* create a module init function */
void
initAckermann() {
    PyObject *m, *d;
    (void)Py_InitModule("Ackermann", AckermannMethods);
}

/* recursive C implementation of Ackermann's function */
int Ack1(int M, int N) {
    if (M == 0) { return(N + 1); }
    if (N == 0) { return(Ack1(M - 1, 1)); }
    return(Ack1(M - 1, Ack1(M, (N - 1))));
}

/* Python glue function to call Ackermann's function */
static PyObject *
Ack(self, args)
    PyObject *self;
    PyObject *args;
{
    int M, N;
    if (!PyArg_ParseTuple(args, "ii", &M, &N))
	return NULL;
    return Py_BuildValue("i", Ack1(M,N));
}
