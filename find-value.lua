#!/usr/bin/env lua5.4
-- SPDX-License-Identifier: MPL-2.0
--[[
--	look for value at specified offset
--	Copyright (c) 2024 Yao Zi.
--]]

local io		= require "io";
local string		= require "string";
local math		= require "math";

local filename = assert(arg[1]);
local content = assert(io.open(filename, 'r')):read('a');
local offset = assert(math.tointeger(arg[2]));
local data = content:sub(offset + 1, -1);

if not arg[3] or arg[3] == 's' then
	print(data:match('[^\0]+'));
elseif arg[3] == 'u32' then
	local num = string.unpack('>I4', data);
	print(("%u 0x%x"):format(num, num));
end
