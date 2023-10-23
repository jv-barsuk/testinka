document.addEventListener("DOMContentLoaded", main())

function main() {
    setTimeout(addButtonFunction, 2000) //TODO: hacky
    setTimeout(setStatus, 2000) //TODO: hacky
    setKeyListeners()
}

function addButtonFunction() {    
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

function setStatus() {
    let teststeps = Array.from(document.getElementsByClassName("teststep"))
    teststeps.forEach(step => {
        step.addEventListener("click", (event) => {
            console.log("click")
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