import React from 'react'
import './Content.css'
import { Image } from '@chakra-ui/react';


function Content() {
    const handleCardClick = () => {
        console.log('Added');
        //adding to cart API here
    };
    return (
        <div>
            <div className="cardd" onClick={handleCardClick}>
                <div className="image"><Image src='https://images.unsplash.com/photo-1555041469-a586c61ea9bc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80'
                    alt='Green double couch with wooden legs' /></div>
                <span className="title">Dummy Product</span>
                <span className="price">$500</span>
            </div>
        </div>
    )
}

export default Content
