export const openSidebarRight = (width) => {
    document.getElementById("sidebarEdit").style.width = width;
    document.getElementById("content").style.marginRight = width;
  }
  
export  const closeSidebarRight = () =>{
    document.getElementById("sidebarEdit").style.width = "0";
    document.getElementById("content").style.marginRight= "0";
  }