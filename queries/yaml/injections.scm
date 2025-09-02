; extends
(block_mapping_pair
  key: (flow_node) @key (#eq? @key ".snippets")
  value: (block_node
    (block_mapping (block_mapping_pair
      value: (block_node
        (block_sequence (block_sequence_item
          (_) ; either flow_node or block_node, for single or multiline strings
          @injection.content
          (#set! injection.include-children)
          (#set! injection.language "bash"))))))))
