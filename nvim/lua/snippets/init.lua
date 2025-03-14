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

local quick_union_rollback = require('snippets.quick-union-rollback')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'quick_union_rollback',
            namr = 'quick_union_rollback',
            dscr = 'Union Find (with Rollback)',
        },{
            text(lines(quick_union_rollback))
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

local sparse_table_2d = require('snippets.sparse-table-2d')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'sparse_table_2d',
            namr = 'sparse_table_2d',
            dscr = '2D Sparse Table',
        },{
            text(lines(sparse_table_2d))
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
local edmonds_karp = require('snippets.edmonds-karp')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'edmonds_karp',
            namr = 'edmonds_karp',
            dscr = 'Max flow using Edmonds-Karp',
        },{
            text(lines(edmonds_karp))
        })
    }
})
local dinic = require('snippets.dinic')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'dinic',
            namr = 'dinic',
            dscr = 'Max flow using Dinic',
        },{
            text(lines(dinic))
        })
    }
})
local mcmf = require('snippets.mcmf')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'mcmf',
            namr = 'mcmf',
            dscr = 'Minimum cost max flow',
        },{
            text(lines(mcmf))
        })
    }
})
local bounded_mcmf = require('snippets.bounded-mcmf')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'bounded_mcmf',
            namr = 'bounded_mcmf',
            dscr = 'Minimum cost (max) flow with bounds',
        },{
            text(lines(bounded_mcmf))
        })
    }
})
local bounded_flow = require('snippets.bounded-flow')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'bounded_flow',
            namr = 'bounded_flow',
            dscr = 'Max/min-flow with bounds',
        },{
            text(lines(bounded_flow))
        })
    }
})
local soe = require('snippets.soe')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'soe',
            namr = 'soe',
            dscr = 'Sieve of Euler',
        },{
            text(lines(soe))
        })
    }
})
local get_phi = require('snippets.get-phi')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'get_phi',
            namr = 'get_phi',
            dscr = 'Sieve of Euler',
        },{
            text(lines(get_phi))
        })
    }
})
local hld = require('snippets.hld')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'hld',
            namr = 'hld',
            dscr = 'Heavy-light decomposition',
        },{
            text(lines(hld))
        })
    }
})
local factcount = require('snippets.factcount')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'factcount',
            namr = 'factcount',
            dscr = 'Get primes and the count of factors of each number',
        },{
            text(lines(factcount))
        })
    }
})

local binary_trie = require('snippets.binary-trie')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'binary_trie',
            namr = 'binary_trie',
            dscr = '01-Trie',
        },{
            text(lines(binary_trie))
        })
    }
})

local lca = require('snippets.lca')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'lca',
            namr = 'lca',
            dscr = 'LCA',
        },{
            text(lines(lca))
        })
    }
})

local fft = require('snippets.fft')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'fft',
            namr = 'fft',
            dscr = 'FFT',
        },{
            text(lines(fft))
        })
    }
})

local ntt = require('snippets.ntt')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'ntt',
            namr = 'ntt',
            dscr = 'NTT',
        },{
            text(lines(ntt))
        })
    }
})

local basis = require('snippets.basis')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'basis',
            namr = 'basis',
            dscr = 'Bit-mask space basis',
        },{
            text(lines(basis))
        })
    }
})

local hierholzer = require('snippets.hierholzer')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'hierholzer',
            namr = 'hierholzer',
            dscr = 'Find Euler path',
        },{
            text(lines(hierholzer))
        })
    }
})

local ebcc = require('snippets.ebcc')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'ebcc',
            namr = 'ebcc',
            dscr = 'eBCC on simple undirected graph',
        },{
            text(lines(ebcc))
        })
    }
})

local ebcc_with_mult = require('snippets.ebcc-with-mult')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'ebcc_with_mult',
            namr = 'ebcc_with_mult',
            dscr = 'eBCC on common undirected graph (with multiple edges)',
        },{
            text(lines(ebcc_with_mult))
        })
    }
})

local manacher = require('snippets.manacher')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'manacher',
            namr = 'manacher',
            dscr = 'Manacher algorithm for counting palindrome substrings',
        },{
            text(lines(manacher))
        })
    }
})

local odt = require('snippets.odt')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'odt',
            namr = 'odt',
            dscr = 'Old Driver Tre',
        },{
            text(lines(odt))
        })
    }
})

local segtree_persistent = require('snippets.segtree-persistent')
ls.add_snippets(nil, {
    cpp = {
        snip({
            trig = 'segtree_persistent',
            namr = 'segtree_persistent',
            dscr = 'Persistent Segment Tree',
        },{
            text(lines(segtree_persistent))
        })
    }
})
