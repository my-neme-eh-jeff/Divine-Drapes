import React from 'react'
import './Address.css'
import { ChakraProvider, Link } from '@chakra-ui/react'
import { ExternalLinkIcon } from '@chakra-ui/icons'
import { useEffect } from 'react'
import privateAxios from "../../../Axios/privateAxios";
import useAuth from "../../../Hooks/useAuth";
import { useState } from 'react';
function Address(props) {
    const { auth, setAuth } = useAuth();
    const isLogin = auth?.accessToken;
    console.log(isLogin);
    console.log(props);
    const [addressList, setAddressList] = useState([]);
    useEffect(() => {
        let config = {
          method: "GET",
          url: "https://divine-drapes.onrender.com/user/profile",
          headers:{
            Authorization:"Bearer "+isLogin
          }
        };
        async function makeRequest() {
          try {
            const response = await privateAxios.request(config);
            console.log(response.data.data.addressList[0]);
            setAddressList(response.data.data.addressList[0]);
          } catch (error) {
            console.log(error);
          }
        }
        makeRequest();
      }, []);
    return (
        <ChakraProvider>
        <div>
            <div className="containerrr">
                <form>
                    <label>
                        <input type="radio" name="radio" />
                        <span>{addressList.addressOf} <br />
                        {addressList.houseNumber} , {addressList.building} <br />
                        {addressList.street} , {addressList.city} <br />
                        {addressList.state} , {addressList.country}
                        </span>
                    </label>
                    <br />
                    <Link href='/addAddress' isExternal>
                        Want to Add/Edit a new Address... <ExternalLinkIcon mx='2px' />
                    </Link>
                </form>
            </div>
        </div>
        </ChakraProvider>
    )
}

export default Address
