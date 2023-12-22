import React, { useState } from 'react'
// import './Content.css'
import { Image, Flex, Stack, Heading, Text, Button } from '@chakra-ui/react';
import { ArrowBackIcon } from '@chakra-ui/icons'
import FavoriteBorderIcon from '@mui/icons-material/FavoriteBorder';
import FavoriteIcon from '@mui/icons-material/Favorite';


function Content(props) {
    const [favIcon, setFavIcon] = useState(false);
    const handleCardClick = () => {
        console.log('Added');
        //adding to cart API here
    };
    return (
        <div>
            {/* <div className="cardd" onClick={handleCardClick}>
                <div className="image"><Image src='https://images.unsplash.com/photo-1555041469-a586c61ea9bc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80'
                    alt='Green double couch with wooden legs' /></div>
                <span className="title">Dummy Product</span>
                <span className="price">$500</span>
            </div> */}
            <Flex direction="column" alignItems="center" maxWidth="400px" m="auto" p="1rem">
                <Image
                    src={props.imagee}
                    alt="Green double couch with wooden legs"
                    borderRadius="lg"
                    width="100%"
                    height="auto"
                />

                <Flex justifyContent="space-between" mt="1rem" width="100%">
                    <Stack spacing="0">
                        <Heading size="md">{props.title}</Heading>
                        <Text fontSize="sm" fontWeight="550">
                            {props.desc}
                        </Text>
                    </Stack>
                    <Stack spacing="1" mr="3">
                        <Text fontSize="xl" fontWeight="bold">
                            ₹{props.price}
                        </Text>
                    </Stack>
                </Flex>

                <Flex justifyContent="space-between" width="100%" mt="1rem">
                    <Button bgColor="#f7bc62" width={"121px"} flex="1" m="0 5px" p="0 10%">
                        Add to Cart
                    </Button>
                    <Button bgColor="white" flex="1" m="0 5px">
                        {!favIcon ? <FavoriteBorderIcon /> : <FavoriteIcon sx={{ color: 'red' }} />}
                    </Button>
                </Flex>
            </Flex>
        </div>
    )
}

export default Content
