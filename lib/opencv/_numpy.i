/* Copyright (c) 2015, OpenCV-SWIG library authors (see AUTHORS file).
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are
 * permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this list of
 * conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its contributors may be
 * used to endorse or promote products derived from this software without specific prior
 * written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
 * THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

%pythoncode
{
    import sys
    if sys.byteorder == 'little':
        _cv_numpy_endianess = '<'
    else:
        _cv_numpy_endianess = '>'

    _cv_numpy_typestr_map = {}
}

%inline
%{
    template <typename T>
    struct _SizeOf
    {
        enum {value = sizeof(T)};
    };
%}

%define %cv_numpy_add_type(type, np_basic_type)
    #if !_CV_NUMPY_##type##_
        %template(_cv_numpy_sizeof_##type) _SizeOf< type >;
        %pythoncode
        {
            if _cv_numpy_sizeof_##type##.value == 1:
                _cv_numpy_typestr_map[#type] = "|" + #np_basic_type + "1"
            else:
                _cv_numpy_typestr_map[#type] = _cv_numpy_endianess  + #np_basic_type + str(_cv_numpy_sizeof_##type##.value)
        }
        #define _CV_NUMPY_##type##_
    #endif
%enddef
