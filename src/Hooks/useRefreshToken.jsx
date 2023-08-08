import privateAxios from "../Axios/privateAxios";
import useAuth from "./useAuth";

export default function useRefreshToken() {
  const { setAuth } = useAuth();
  const refresh = async () => {
    try {
      const options = {
        url: "auth/refreshToken",
        method: "GET",
        withCredentials:true,
      };
      const resp = await privateAxios.request(options);
      setAuth((prev) => {
        console.log(JSON.stringify(prev));
        console.log(resp.data.accessToken);
        return { ...prev, accessToken: resp.data.accessToken };
      });
      return resp.data.accessToken;
    } catch (err) {
      console.log(err);
    }
  };
  return refresh;
}
