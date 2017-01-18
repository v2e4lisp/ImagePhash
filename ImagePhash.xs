#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"
#include "pHash.h"
#include "CImg.h"

#include <stdlib.h>

int valid_hex(char *s) {
        char c;
        for (; *s; s++) {
                c = *s;
                if (c >= '0' && c <= '9') {
                        continue;
                }
                if (c >= 'a' && c <= 'f') {
                        continue;
                }

                return 0;
        }

        return 1;
}

MODULE = ImagePhash		PACKAGE = ImagePhash		

SV*
phash(const char *file)
CODE:
{
        int ret;
        ulong64 hash;

        ret = ph_dct_imagehash(file, hash);
        if (ret != 0) {
                croak("failed to calculate phash for %s", file);
        }

        RETVAL = newSV(16);
        sv_setpvf(RETVAL, "%016llx", hash);
}
OUTPUT:
RETVAL


int
pdiff(SV *v1, SV *v2)
CODE:
{
        STRLEN len1;
        STRLEN len2;
        char *s1;
        char *s2;
        ulong64 hash1;
        ulong64 hash2;

        if (!SvPOK(v1) || !SvPOK(v2)) {
                croak("16 byte lowercase hex strings expected.");
        }

        s1 = SvPV(v1, len1);
        if (len1 != 16 || !valid_hex(s1)) {
                croak("16 byte lowercase hex strings expected");
        }

        s2 = SvPV(v2, len2);
        if (len2 != 16 || !valid_hex(s2)) {
                croak("16 byte lowercase hex strings expected");
        }

        hash1 = strtoull(s1, 0, 16);
        hash2 = strtoull(s2, 0, 16);
        RETVAL = ph_hamming_distance(hash1, hash2);
}
OUTPUT:
RETVAL

