# Makefile for uAPI

.PHONY: all clean

# Source files for the uAPI Service
SRV_SRCS = uapi_srv.c
SRV_OBJS = uapi_srv.o

PROC_SRCS = base64.c bstrlib.c configuration/configuration.c \
	configuration/ini.c http_parser.c http_request.c http_response.c \
	http_response_cache.c http_server.c hw_string.c route_compare_method.c \
	server_stats.c uapi.c

PROC_OBJS = $(PROC_SRCS:.c=.o)

CC = gcc
INTERNAL_CFLAGS = -Wall -O2 -I/usr/local/include -pthread -I. -DDEBUG -DPLATFORM_POSIX
CPPFLAGS += -MMD -MP -MT $@
LDFLAGS = -L/usr/local/lib

EXE1 = uapi_service
EXE2 = uapi_proc
LIBS = -luv

all: $(EXE1) $(EXE2)

$(EXE1): $(SRV_OBJS)
	$(CC) $(INTERNAL_CFLAGS) -o $(EXE1) $(SRV_OBJS) $(LDFLAGS) $(LIBS)

$(EXE2): $(PROC_OBJS)
	$(CC) $(INTERNAL_CFLAGS) -o $(EXE2) $(PROC_OBJS) $(LDFLAGS) $(LIBS)


clean:
	rm -f $(EXE1) $(EXE2) $(SRV_OBJS) $(PROC_OBJS)

.c.o:
	$(CC) $(INTERNAL_CFLAGS) $(CPPFLAGS) -o $@ -c $<

# Include automatically generated dependency files
-include $(wildcard *.d)
