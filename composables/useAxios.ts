import axios from 'axios';
import { useUser } from '~/stores/user';
import {urlRefreshToken} from '~/api/setupAPI';
export const useAxios = () => {
    //config axios, baseUrl and header
    axios.defaults.baseURL = '';
    axios.defaults.headers.common['Authorization'] = 'Bearer ' + useUser().getUser().token;
    axios.defaults.headers.common['Cache-Control'] = 'no-cache';
    axios.defaults.headers.common['Pragma'] = 'no-cache';
    //if exception is 404
    axios.interceptors.response.use(response => {
        return response;
    }, error => {
        console.log(error);
        if (error.response.status === 404) {
            console.log('404 error');
            //navigateTo('/login');
        }
        return Promise.reject(error);
    });
    //if exception is 401
    axios.interceptors.response.use(response => {
        return response;
    }, error => {
        if (error.response.status === 401) {
                var refreshToken = encodeURIComponent(useUser().getUser().refreshToken);
               return Promise.resolve(axios.get(`${urlRefreshToken}?refreshToken=${refreshToken}`,{
                headers: {
                     'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache'
                }
               }).then(response => {
                    useUser().setUser(response.data);
                    error.config.headers['Authorization'] = 'Bearer ' + useUser().getUser().token;
                    error.config.headers['Cache-Control'] = 'no-cache';
                    error.config.headers['Pragma'] = 'no-cache';
                    // // error.config.baseURL =  ;
                    return axios.request(error.config);
                }).catch(() => {
                    navigateTo('/login');
                }));
            
            console.log('401 error');
          
            //navigateTo('/login');
        }
        return Promise.reject(error);
    });
    return useState('vaxios', () => axios)
}