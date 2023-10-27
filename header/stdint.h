#ifndef STDINT_H
#define STDINT_H

// 8-bit types
typedef unsigned char uint8_t;
typedef signed char int8_t;

// 16-bit types
typedef unsigned short uint16_t;
typedef signed short int16_t;

// 32-bit types
typedef unsigned int uint32_t;
typedef signed int int32_t;

// 64-bit types (if supported in your environment)
typedef unsigned long long uint64_t;
typedef signed long long int64_t;

// Define size-related types
typedef unsigned int size_t;
typedef int ptrdiff_t;

#endif

