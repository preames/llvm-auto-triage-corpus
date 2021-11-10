# RUN: clang -cc1as -triple i386-- -filetype obj %s
# XFAIL: *
.intel_syntax noprefix
push offset termin_error_string@GOT
