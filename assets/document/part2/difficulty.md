# What is "difficulty"?

Difficulty is a measure of how difficult it is to find a hash below a given target.

The Bitcoin network has a global block difficulty. Valid blocks must have a hash below this target. Mining pools also have a pool-specific share difficulty setting a lower limit for shares.

# What is the formula for difficulty?

difficulty = difficulty_1_target / current_target

(target is a 256 bit number)

difficulty_1_target can be different for various ways to measure difficulty. Traditionally, it represents a hash where the leading 32 bits are zero and the rest are one (this is known as "pool difficulty" or "pdiff"). The Bitcoin protocol represents targets as a custom floating point type with limited precision; as a result, Bitcoin clients often approximate difficulty based on this (this is known as "bdiff").

How is difficulty stored in blocks?
Each block stores a packed representation (called "Bits") for its actual hexadecimal target. The target can be derived from it via a predefined formula. For example, if the packed target in the block is 0x1b0404cb (stored in little-endian order: cb 04 04 1b), the hexadecimal target is
