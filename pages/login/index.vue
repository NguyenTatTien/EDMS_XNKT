<template>
    <div class="h-screen background-1 w-full flex items-center justify-center">
        <section class="bg-white rounded-lg shadow-md p-3 w-[320px] flex flex-wrap justify-center">
            <img v-shared-element:img1 class="rounded-lg h-48 w-60" src="/assets/images/THEA_Logo_vn_Backup.png" />
            <form action="" class="w-full">
                      <div class="w-full mt-1 text-center">
                          <InputText id="txtUsername" type="text" placeholder="Username" v-model="model.username" class="my-2 w-full border border-gray-300 p-2 rounded-none"/>
                        </div>
                        <div class="w-full mt-1 text-center">
                          <InputText id="txtPassword" type="password" placeholder="Password" v-model="model.password" class="my-2 w-full border border-gray-300 p-2 rounded-none" @keydown="handleKeydown"/>       
                        </div>
                        <div class="w-full mt-1 text-center">
                          <Button type="button" @click="login" class="btnLogin w-full p-1 rounded-none" label="Login"/>
                        </div>
                    </form>
        </section>
        <Toast />
    </div>
</template>
<script setup>
import { ref,onMounted } from 'vue'
import { useUser } from "~/stores/user";
import { useToast } from "primevue/usetoast";
import { userLogin } from '~/api/userAPI';
import { UserLoginHistory } from '~/models/userLoginHistory.js';
import { parse  } from 'date-fns';
import { useMenu } from '~/stores/menu';
import { useCategories } from '~/stores/categories';
import { useFolder } from '~/stores/folder';
const toast = useToast();

const userLoginHistory = ref(new UserLoginHistory());
//use blank layout
definePageMeta({
  layout: 'blank'
})
const model = ref({
    username: "",
    password: ""
}) 
const handleKeydown = (event) => {
      if (event.key === 'Enter') {
        login(); 
      }
    };
const login =async () => {
    try{
        if(model.value.username === "" || model.value.password === ""){
        toast.add({ severity: 'error', summary: 'Error', detail: "UserName or Password needs to be entered!", life: 5000 });
    }else{
        await GetInfor();
        var data = await useUser().login(userLoginHistory.value,model.value.username, model.value.password);
            var user = data;
            useUser().setUser(user);
            useMenu().clearMenu();
            useCategories().clearCategories();
            useFolder().clearFolders();
         //   sessionStorage.setItem("userLogin", JSON.stringify(user));
            navigateTo('/document_library');
    }
    }catch(error){
        if( error.response != null && error.response.data.message === "UserName or Password incorrect!"){
            toast.add({ severity: 'error', summary: 'Error', detail: "UserName or Password incorrect!", life: 5000 });
        }else{
            toast.add({ severity: 'error', summary: 'Error', detail: "Login failed!", life: 5000 });
            console.log("Error login:"+error);
        }
    }
}  
const GetInfor = async()=>{
    
      var getbrowser = "";
      var osystem = "";
      var offset = new Date().getTimezoneOffset(), o = Math.abs(offset);
      offset = (offset < 0 ? "+" : "-") + ("00" + Math.floor(o / 60)).slice(-2) + ":" + ("00" + (o % 60)).slice(-2);
      userLoginHistory.value.localTimeZone = offset;
      var year = new Date().getFullYear();
      var month = new Date().getMonth()+1;
      var day = new Date().getDate();
      var hh = new Date().getHours();
      var m = new Date().getMinutes();
      var s = new Date().getSeconds();
      var ss = new Date().getMilliseconds();
      var time = hh+ ":" +m+ ":" + s+ ":" +ss ;
      var date = day + "/" + month + "/" + year ;
        userLoginHistory.value.localTime = new Date();
      var unknown = '-';
      var nVer = navigator.appVersion;
      var nAgt = navigator.userAgent;
      var browserName = navigator.appName;
      const languageMap = {
            'en-US': 'English (United States)',
            'en-GB': 'English (United Kingdom)',
            'vi-VN': 'Tiếng Việt (Việt Nam)',
            'fr-FR': 'Français (France)',
            // Thêm các ngôn ngữ khác tại đây
        };
        const languageFullName = languageMap[navigator.language] || navigator.language;
      userLoginHistory.value.languageFormat = languageFullName;
      var fullVersion = '' + parseFloat(navigator.appVersion);
      var majorVersion = parseInt(navigator.appVersion, 10);
      var nameOffset, verOffset, ix;

      // In Opera, the true version is after "Opera" or after "Version"
      if ((verOffset = nAgt.indexOf("Opera")) != -1) {
          browserName = "Opera";
          fullVersion = nAgt.substring(verOffset + 6);
          if ((verOffset = nAgt.indexOf("Version")) != -1)
              fullVersion = nAgt.substring(verOffset + 8);
      }
          // In MSIE, the true version is after "MSIE" in userAgent
      else if ((verOffset = nAgt.indexOf("MSIE")) != -1) {
          browserName = "Microsoft Internet Explorer";
          fullVersion = nAgt.substring(verOffset + 5);
      }
      else if ((verOffset = nAgt.indexOf("coc_coc_browser")) != -1) {
          browserName = "coc_coc";
          fullVersion = nAgt.substring(verOffset + 16);
      }
          // In Chrome, the true version is after "Chrome" 
      else if ((verOffset = nAgt.indexOf("Chrome")) != -1) {
          browserName = "Chrome";
          fullVersion = nAgt.substring(verOffset + 7);
      }
          // In Safari, the true version is after "Safari" or after "Version" 
      else if ((verOffset = nAgt.indexOf("Safari")) != -1) {
          browserName = "Safari";
          fullVersion = nAgt.substring(verOffset + 7);
          if ((verOffset = nAgt.indexOf("Version")) != -1)
              fullVersion = nAgt.substring(verOffset + 8);
      }
          // In Firefox, the true version is after "Firefox" 
      else if ((verOffset = nAgt.indexOf("Firefox")) != -1) {
          browserName = "Firefox";
          fullVersion = nAgt.substring(verOffset + 8);
      }
          // In most other browsers, "name/version" is at the end of userAgent 
      else if ((nameOffset = nAgt.lastIndexOf(' ') + 1) < (verOffset = nAgt.lastIndexOf('/'))) {
          browserName = nAgt.substring(nameOffset, verOffset);
          fullVersion = nAgt.substring(verOffset + 1);
          if (browserName.toLowerCase() == browserName.toUpperCase()) {
              browserName = navigator.appName;
          }
      }
      // trim the fullVersion string at semicolon/space if present
      if ((ix = fullVersion.indexOf(";")) != -1)
          fullVersion = fullVersion.substring(0, ix);
      if ((ix = fullVersion.indexOf(" ")) != -1)
          fullVersion = fullVersion.substring(0, ix);
      majorVersion = parseInt('' + fullVersion, 10);
      if (isNaN(majorVersion)) {
          fullVersion = '' + parseFloat(navigator.appVersion);
          majorVersion = parseInt(navigator.appVersion, 10);
      }
      getbrowser = browserName + " (" + fullVersion + ")";
      var os = unknown;
      var clientStrings = [
          { s: 'Windows 11', r: /(Windows 11.0|Windows NT 11.0)/ },
          { s: 'Windows 10', r: /(Windows 10.0|Windows NT 10.0)/ },
          { s: 'Windows 8.1', r: /(Windows 8.1|Windows NT 6.3)/ },
          { s: 'Windows 8', r: /(Windows 8|Windows NT 6.2)/ },
          { s: 'Windows 7', r: /(Windows 7|Windows NT 6.1)/ },
          { s: 'Windows Vista', r: /Windows NT 6.0/ },
          { s: 'Windows Server 2003', r: /Windows NT 5.2/ },
          { s: 'Windows XP', r: /(Windows NT 5.1|Windows XP)/ },
          { s: 'Windows 2000', r: /(Windows NT 5.0|Windows 2000)/ },
          { s: 'Windows ME', r: /(Win 9x 4.90|Windows ME)/ },
          { s: 'Windows 98', r: /(Windows 98|Win98)/ },
          { s: 'Windows 95', r: /(Windows 95|Win95|Windows_95)/ },
          { s: 'Windows NT 4.0', r: /(Windows NT 4.0|WinNT4.0|WinNT|Windows NT)/ },
          { s: 'Windows CE', r: /Windows CE/ },
          { s: 'Windows 3.11', r: /Win16/ },
          { s: 'Android', r: /Android/ },
          { s: 'Open BSD', r: /OpenBSD/ },
          { s: 'Sun OS', r: /SunOS/ },
          { s: 'Linux', r: /(Linux|X11)/ },
          { s: 'iOS', r: /(iPhone|iPad|iPod)/ },
          { s: 'Mac OS X', r: /Mac OS X/ },
          { s: 'Mac OS', r: /(MacPPC|MacIntel|Mac_PowerPC|Macintosh)/ },
          { s: 'QNX', r: /QNX/ },
          { s: 'UNIX', r: /UNIX/ },
          { s: 'BeOS', r: /BeOS/ },
          { s: 'OS/2', r: /OS\/2/ },
          { s: 'Search Bot', r: /(nuhk|Googlebot|Yammybot|Openbot|Slurp|MSNBot|Ask Jeeves\/Teoma|ia_archiver)/ }
      ];
      for (var id in clientStrings) {
          var cs = clientStrings[id];
          if (cs.r.test(nAgt)) {
              os = cs.s;
              break;
          }
      }
      var osVersion = unknown;
      if (/Windows/.test(os)) {
          osVersion = /Windows (.*)/.exec(os)[1];
          os = 'Windows';
      }
      switch (os) {
          case 'Mac OS X':
              osVersion = /Mac OS X (10[\.\_\d]+)/.exec(nAgt)[1];
              break;

          case 'Android':
              osVersion = /Android ([\.\_\d]+)/.exec(nAgt)[1];
              break;

          case 'iOS':
              osVersion = /OS (\d+)_(\d+)_?(\d+)?/.exec(nVer);
              osVersion = osVersion[1] + '.' + osVersion[2] + '.' + (osVersion[3] | 0);
              break;
      }
      osystem = os + ' ' + osVersion;
      userLoginHistory.value.osDetail = osystem;
      userLoginHistory.value.browser = getbrowser;
      try {
      var response = await fetch('https://jsonip.com');
      var data = await response.json();
      userLoginHistory.value.ipAddress = data.ip;
    } catch (error) {
      console.error("Error fetching IP address:", error);
    }
}
</script>
<style>
body {
    padding: 0;
    margin: 0;
}
.background-1 {
    background-image: url('https://www.vietsov.com.vn/_catalogs/masterpage/vietsov/assets/images/intro/bh.jpg');
    background-size: cover;
    background-repeat: no-repeat;
}
</style>