/*
 * opencog/destin/atom_types_init.cc
 *
 * Copyright (C) 2014 Linas Vepstas
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License v3 as
 * published by the Free Software Foundation and including the exceptions
 * at http://opencog.org/wiki/Licenses
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program; if not, write to:
 * Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#include <opencog/cogserver/server/Module.h>

#include "opencog/moviedb/atom_types.definitions"


#define INHERITANCE_FILE "opencog/moviedb/atom_types.inheritance"

#define INITNAME moviedb_types_init

#include <opencog/atoms/base/atom_types.cc>

using namespace opencog;
TRIVIAL_MODULE(MoviedbTypesModule)
DECLARE_MODULE(MoviedbTypesModule)

