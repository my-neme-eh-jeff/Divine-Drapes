import React from 'react'
import './Address.css'
import { ChakraProvider, Link } from '@chakra-ui/react'
import { ExternalLinkIcon } from '@chakra-ui/icons'

function Address(props) {
    return (
        <ChakraProvider>
        <div>
            <div class="containerrr">
                <form>
                    <label>
                        <input type="radio" name="radio" />
                        <span>{props.title} <br />
                        {props.houseNumber} , {props.building} <br />
                        {props.street} , {props.city} <br />
                        {props.state} , {props.country}
                        </span>
                    </label>
                    {/* <label>
                        <input type="radio" name="radio" />
                        <span>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Magni nostrum repellendus eligendi.</span>
                    </label>
                    <label>
                        <input type="radio" name="radio" />
                        <span>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Inventore harum esse omnis voluptatem, eveniet, aspernatur labore obcaecati at officiis ratione nihil maiores. Obcaecati odio repellat ad dignissimos id laudantium veritatis!</span>
                    </label> */}
                    <br />
                    <Link href='/' isExternal>
                        Want to Add a new Address... <ExternalLinkIcon mx='2px' />
                    </Link>
                </form>
            </div>
        </div>
        </ChakraProvider>
    )
}

export default Address
