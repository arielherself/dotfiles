local ls = require('luasnip')
local snip = ls.snippet
local text = ls.text_node


local function lines(str)
  local result = {}
  for line in str:gmatch '[^\n]+' do
    table.insert(result, line)
  end
  return result
end

local cpp_include = require('snippets.cpp-include')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'include',
            namr = 'cpp-include',
            dscr = 'Useful Macros',
        },{
            text(lines(cpp_include))
        })
    }
})

local segtree_generic = require('snippets.segtree-generic')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'segtree',
            namr = 'segtree_generic',
            dscr = 'Segment Tree with Lazy Propagation',
        },{
            text(lines(segtree_generic))
        })
    }
})

local fhq_treap = require('snippets.fhq-treap')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'treap',
            namr = 'fhq_treap',
            dscr = 'FHQ Treap',
        },{
            text(lines(fhq_treap))
        })
    }
})

local fhq_treap = require('snippets.fhq-treap')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'treap',
            namr = 'fhq_treap',
            dscr = 'FHQ Treap',
        },{
            text(lines(fhq_treap))
        })
    }
})

local bit = require('snippets.bit')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'bit',
            namr = 'bit',
            dscr = 'Bit-Indexed Tree',
        },{
            text(lines(bit))
        })
    }
})

local quick_union = require('snippets.quick-union')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'quick_union',
            namr = 'quick_union',
            dscr = 'Union Find',
        },{
            text(lines(quick_union))
        })
    }
})

local sparse_table = require('snippets.sparse-table')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'sparse_table',
            namr = 'sparse_table',
            dscr = 'Sparse Table',
        },{
            text(lines(sparse_table))
        })
    }
})

local hash_deque = require('snippets.hash-deque')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'hash_deque',
            namr = 'hash_deque',
            dscr = 'Hashable Deque',
        },{
            text(lines(hash_deque))
        })
    }
})

local hash_vec = require('snippets.hash-vec')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'hash_vec',
            namr = 'hash_vec',
            dscr = 'Hashable Vector',
        },{
            text(lines(hash_vec))
        })
    }
})

local exgcd = require('snippets.exgcd')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'exgcd',
            namr = 'exgcd',
            dscr = 'Extended GCD and Related',
        },{
            text(lines(exgcd))
        })
    }
})

local lpf = require('snippets.lpf')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'lpf',
            namr = 'lpf',
            dscr = 'Least Prime Factor',
        },{
            text(lines(lpf))
        })
    }
})

local pollard_rho = require('snippets.pollard-rho')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'pollard_rho',
            namr = 'pollard_rho',
            dscr = 'Pollard-Rho',
        },{
            text(lines(pollard_rho))
        })
    }
})

local tarjan = require('snippets.tarjan')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'tarjan',
            namr = 'tarjan',
            dscr = 'Tarjan and Related',
        },{
            text(lines(tarjan))
        })
    }
})
