import React from 'react'
import './Address.css'
import { Link } from '@chakra-ui/react'
import { ExternalLinkIcon } from '@chakra-ui/icons'

function Address() {
    return (
        <div>
            <div class="containerrr">
                <form>
                    <label>
                        <input type="radio" name="radio" />
                        <span>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quod, corrupti odio assumenda dolorum amet, eligendi ex reprehenderit quibusdam expedita placeat cum facilis voluptatum sit nemo.</span>
                    </label>
                    <label>
                        <input type="radio" name="radio" />
                        <span>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Magni nostrum repellendus eligendi.</span>
                    </label>
                    <label>
                        <input type="radio" name="radio" />
                        <span>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Inventore harum esse omnis voluptatem, eveniet, aspernatur labore obcaecati at officiis ratione nihil maiores. Obcaecati odio repellat ad dignissimos id laudantium veritatis!</span>
                    </label>
                    <br />
                    <Link href='/' isExternal>
                        Want to Add a new Address... <ExternalLinkIcon mx='2px' />
                    </Link>
                </form>
            </div>
        </div>
    )
}

export default Address
