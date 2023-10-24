docReady(main)
function main() {
    setButtonListener()
    setStatusListener()
    setKeyListeners()
}

function docReady(fn) {
    // see if DOM is already available
    if (document.readyState === "complete" || document.readyState === "interactive") {
        // call on next available tick
        setTimeout(fn, 1);
    } else {
        document.addEventListener("DOMContentLoaded", fn);
    }
} 

function setButtonListener() {    
    Array.from(document.getElementsByTagName("button")).forEach(button => {
        button.addEventListener("click", (event) => {
            let children = Array.from(event.target.parentNode.children)
            children.forEach(child => {
                toggleDisplay(child)
            })
            button.style.display = "inline"
        })
    });
}

function toggleDisplay(element) {
    console.log(element.style.display)
    if(element.style.display == "none" || element.style.display == undefined) {
        console.log("in")
        element.style.display="inline"
    } else {
        element.style.display="none"
    }
}

function setStatusListener() {
    let teststeps = Array.from(document.getElementsByClassName("teststep"))
    teststeps.forEach(step => {
        step.addEventListener("click", (event) => {
            teststeps.forEach(element => {
                element.classList.remove("active")
            })
            event.target.parentNode.classList.add("active") //because tr can't be clicked
        })
    })
}

function setKeyListeners() {
    document.addEventListener("keypress", (event) => {
        switch (event.key) {
            case "1": 
                setResultForActive("ok")
                break;
            case "2": 
                setResultForActive("fail")
                break;
            case "3": 
                setResultForActive("ignored")
                break;
        }
    })
}

function setResultForActive(status) {
    let activeElement = document.querySelector("tr.active")
    console.log(activeElement)
    if(activeElement == null) {return}
    try {
        activeElement.querySelector(".button_"+status).click()
        activeElement.closest("tr").nextSibling.classList.add("active")
    } catch(e) {}
    
}