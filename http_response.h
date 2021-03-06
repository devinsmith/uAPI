#ifndef __HW_HTTP_RESPONSE_H__
#define __HW_HTTP_RESPONSE_H__

#include "haywire.h"
#include "http_connection.h"

struct http_header {
	hw_string name;
	hw_string value;
};

#define MAX_HEADERS 64

typedef struct
{
    http_connection *connection;
    unsigned short http_major;
    unsigned short http_minor;
    hw_string status_code;
    struct http_header headers[MAX_HEADERS];
    int number_of_headers;
    hw_string body;
    int sent;
} http_response;

hw_http_response hw_create_http_response(http_connection* connection);
hw_string* create_response_buffer(hw_http_response* response);

#endif /* __HW_HTTP_RESPONSE_H__ */
