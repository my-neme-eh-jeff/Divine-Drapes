import React from 'react'
import Content from './Content'
import { Box, ChakraProvider, SimpleGrid } from '@chakra-ui/react'

function Product() {
    return (
        <div>
            <ChakraProvider>
                <Box  display={'flex'} flexWrap={'nowrap'} padding={'100px'}  overflowX={'auto'}
                className='recom'
                >
                    <Content />
                    <Content />
                    <Content />
                    <Content />
                    <Content />
                    <Content />
                    <Content />
                    <Content />
                </Box>
            </ChakraProvider>
        </div>
    )
}

export default Product
