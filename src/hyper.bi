/'
 ' Copyright 2023 XXIV
 '
 ' Licensed under the Apache License, Version 2.0 (the "License");
 ' you may not use this file except in compliance with the License.
 ' You may obtain a copy of the License at
 '
 '     http://www.apache.org/licenses/LICENSE-2.0
 '
 ' Unless required by applicable law or agreed to in writing, software
 ' distributed under the License is distributed on an "AS IS" BASIS,
 ' WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 ' See the License for the specific language governing permissions and
 ' limitations under the License.
'/
#ifndef __HYPER_BI__
#define __HYPER_BI__

extern "C"

const HYPER_ITER_CONTINUE = 0
const HYPER_ITER_BREAK = 1
const HYPER_HTTP_VERSION_NONE = 0
const HYPER_HTTP_VERSION_1_0 = 10
const HYPER_HTTP_VERSION_1_1 = 11
const HYPER_HTTP_VERSION_2 = 20
const HYPER_IO_PENDING = 4294967295
const HYPER_IO_ERROR = 4294967294
const HYPER_POLL_READY = 0
const HYPER_POLL_PENDING = 1
const HYPER_POLL_ERROR = 3

type hyper_code as long
enum
	HYPERE_OK
	HYPERE_ERROR
	HYPERE_INVALID_ARG
	HYPERE_UNEXPECTED_EOF
	HYPERE_ABORTED_BY_CALLBACK
	HYPERE_FEATURE_NOT_ENABLED
	HYPERE_INVALID_PEER_MESSAGE
end enum

type hyper_task_return_type as long
enum
	HYPER_TASK_EMPTY
	HYPER_TASK_ERROR
	HYPER_TASK_CLIENTCONN
	HYPER_TASK_RESPONSE
	HYPER_TASK_BUF
end enum

type hyper_body as hyper_body

type hyper_buf as hyper_buf

type hyper_clientconn as hyper_clientconn

type hyper_clientconn_options as hyper_clientconn_options

type hyper_context as hyper_context

type hyper_error as hyper_error

type hyper_executor as hyper_executor

type hyper_headers as hyper_headers

type hyper_io as hyper_io

type hyper_request as hyper_request

type hyper_response as hyper_response

type hyper_task as hyper_task

type hyper_waker as hyper_waker

type hyper_body_foreach_callback as function(byval as any ptr, byval as const hyper_buf ptr) as long
type hyper_body_data_callback as function(byval as any ptr, byval as hyper_context ptr, byval as hyper_buf ptr ptr) as long
type hyper_request_on_informational_callback as sub(byval as any ptr, byval as hyper_response ptr)
type hyper_headers_foreach_callback as function(byval as any ptr, byval as const ubyte ptr, byval as uinteger, byval as const ubyte ptr, byval as uinteger) as long
type hyper_io_read_callback as function(byval as any ptr, byval as hyper_context ptr, byval as ubyte ptr, byval as uinteger) as uinteger
type hyper_io_write_callback as function(byval as any ptr, byval as hyper_context ptr, byval as const ubyte ptr, byval as uinteger) as uinteger

declare function hyper_version() as const zstring ptr
declare function hyper_body_new() as hyper_body ptr
declare sub hyper_body_free(byval body as hyper_body ptr)
declare function hyper_body_data(byval body as hyper_body ptr) as hyper_task ptr
declare function hyper_body_foreach(byval body as hyper_body ptr, byval func as hyper_body_foreach_callback, byval userdata as any ptr) as hyper_task ptr
declare sub hyper_body_set_userdata(byval body as hyper_body ptr, byval userdata as any ptr)
declare sub hyper_body_set_data_func(byval body as hyper_body ptr, byval func as hyper_body_data_callback)
declare function hyper_buf_copy(byval buf as const ubyte ptr, byval len as uinteger) as hyper_buf ptr
declare function hyper_buf_bytes(byval buf as const hyper_buf ptr) as const ubyte ptr
declare function hyper_buf_len(byval buf as const hyper_buf ptr) as uinteger
declare sub hyper_buf_free(byval buf as hyper_buf ptr)
declare function hyper_clientconn_handshake(byval io as hyper_io ptr, byval options as hyper_clientconn_options ptr) as hyper_task ptr
declare function hyper_clientconn_send(byval conn as hyper_clientconn ptr, byval req as hyper_request ptr) as hyper_task ptr
declare sub hyper_clientconn_free(byval conn as hyper_clientconn ptr)
declare function hyper_clientconn_options_new() as hyper_clientconn_options ptr
declare sub hyper_clientconn_options_set_preserve_header_case(byval opts as hyper_clientconn_options ptr, byval enabled as long)
declare sub hyper_clientconn_options_set_preserve_header_order(byval opts as hyper_clientconn_options ptr, byval enabled as long)
declare sub hyper_clientconn_options_free(byval opts as hyper_clientconn_options ptr)
declare sub hyper_clientconn_options_exec(byval opts as hyper_clientconn_options ptr, byval exec as const hyper_executor ptr)
declare function hyper_clientconn_options_http2(byval opts as hyper_clientconn_options ptr, byval enabled as long) as hyper_code
declare function hyper_clientconn_options_headers_raw(byval opts as hyper_clientconn_options ptr, byval enabled as long) as hyper_code
declare sub hyper_error_free(byval err as hyper_error ptr)
declare function hyper_error_code(byval err as const hyper_error ptr) as hyper_code
declare function hyper_error_print(byval err as const hyper_error ptr, byval dst as ubyte ptr, byval dst_len as uinteger) as uinteger
declare function hyper_request_new() as hyper_request ptr
declare sub hyper_request_free(byval req as hyper_request ptr)
declare function hyper_request_set_method(byval req as hyper_request ptr, byval method as const ubyte ptr, byval method_len as uinteger) as hyper_code
declare function hyper_request_set_uri(byval req as hyper_request ptr, byval uri as const ubyte ptr, byval uri_len as uinteger) as hyper_code
declare function hyper_request_set_uri_parts(byval req as hyper_request ptr, byval scheme as const ubyte ptr, byval scheme_len as uinteger, byval authority as const ubyte ptr, byval authority_len as uinteger, byval path_and_query as const ubyte ptr, byval path_and_query_len as uinteger) as hyper_code
declare function hyper_request_set_version(byval req as hyper_request ptr, byval version as long) as hyper_code
declare function hyper_request_headers(byval req as hyper_request ptr) as hyper_headers ptr
declare function hyper_request_set_body(byval req as hyper_request ptr, byval body as hyper_body ptr) as hyper_code
declare function hyper_request_on_informational(byval req as hyper_request ptr, byval callback as hyper_request_on_informational_callback, byval data as any ptr) as hyper_code
declare sub hyper_response_free(byval resp as hyper_response ptr)
declare function hyper_response_status(byval resp as const hyper_response ptr) as ushort
declare function hyper_response_reason_phrase(byval resp as const hyper_response ptr) as const ubyte ptr
declare function hyper_response_reason_phrase_len(byval resp as const hyper_response ptr) as uinteger
declare function hyper_response_headers_raw(byval resp as const hyper_response ptr) as const hyper_buf ptr
declare function hyper_response_version(byval resp as const hyper_response ptr) as long
declare function hyper_response_headers(byval resp as hyper_response ptr) as hyper_headers ptr
declare function hyper_response_body(byval resp as hyper_response ptr) as hyper_body ptr
declare sub hyper_headers_foreach(byval headers as const hyper_headers ptr, byval func as hyper_headers_foreach_callback, byval userdata as any ptr)
declare function hyper_headers_set(byval headers as hyper_headers ptr, byval name as const ubyte ptr, byval name_len as uinteger, byval value as const ubyte ptr, byval value_len as uinteger) as hyper_code
declare function hyper_headers_add(byval headers as hyper_headers ptr, byval name as const ubyte ptr, byval name_len as uinteger, byval value as const ubyte ptr, byval value_len as uinteger) as hyper_code
declare function hyper_io_new() as hyper_io ptr
declare sub hyper_io_free(byval io as hyper_io ptr)
declare sub hyper_io_set_userdata(byval io as hyper_io ptr, byval data as any ptr)
declare sub hyper_io_set_read(byval io as hyper_io ptr, byval func as hyper_io_read_callback)
declare sub hyper_io_set_write(byval io as hyper_io ptr, byval func as hyper_io_write_callback)
declare function hyper_executor_new() as const hyper_executor ptr
declare sub hyper_executor_free(byval exec as const hyper_executor ptr)
declare function hyper_executor_push(byval exec as const hyper_executor ptr, byval task as hyper_task ptr) as hyper_code
declare function hyper_executor_poll(byval exec as const hyper_executor ptr) as hyper_task ptr
declare sub hyper_task_free(byval task as hyper_task ptr)
declare function hyper_task_value(byval task as hyper_task ptr) as any ptr
declare function hyper_task_type(byval task as hyper_task ptr) as hyper_task_return_type
declare sub hyper_task_set_userdata(byval task as hyper_task ptr, byval userdata as any ptr)
declare function hyper_task_userdata(byval task as hyper_task ptr) as any ptr
declare function hyper_context_waker(byval cx as hyper_context ptr) as hyper_waker ptr
declare sub hyper_waker_free(byval waker as hyper_waker ptr)
declare sub hyper_waker_wake(byval waker as hyper_waker ptr)

end extern

#endif '__HYPER_BI__
