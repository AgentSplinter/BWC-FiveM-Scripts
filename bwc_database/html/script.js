let currentTab = "citizens";

function showAddButtons() {
    document.getElementById("addVehicleBtn").style.display = (currentTab === "vehicles") ? "inline-block" : "none";
    document.getElementById("addWarrantBtn").style.display = (currentTab === "warrants") ? "inline-block" : "none";
    document.getElementById("addTicketBtn").style.display = (currentTab === "tickets") ? "inline-block" : "none";
}

function renderTable(data, headers) {
    let html = `<table class="data-table">
        <thead><tr>`;
    headers.forEach(header => {
        html += `<th>${header.title}</th>`;
    });
    html += `</tr></thead><tbody>`;

    data.forEach(row => {
        html += "<tr>";
        headers.forEach(header => {
            let value = row[header.field];
            if (typeof value === "boolean" || value === 0 || value === 1) {
                if (value === true || value === 1) value = "Yes";
                else if (value === false || value === 0) value = "No";
            }

            if (header.field === "fullname" && row.firstname && row.lastname) {
                value = row.firstname + " " + row.lastname;
            }

            if (value == null) value = "";
            html += `<td>${value}</td>`;
        });
        html += "</tr>";
    });

    html += "</tbody></table>";
    return html;
}

function updateContent(data) {
    const content = document.getElementById("content");
    let html = "";
    if (currentTab === "citizens") {
        // Citizens
        const headers = [
            { title: "ID", field: "id" },
            { title: "Name", field: "fullname" },
            { title: "DOB", field: "dateofbirth" },
            { title: "Height", field: "height" },
            { title: "Gender", field: "sex" },
            { title: "Job", field: "job" },
            { title: "Missing", field: "missing" }
        ];
        html = renderTable(data, headers);
    } else if (currentTab === "vehicles") {
        // Vehicles
        const headers = [
            { title: "ID", field: "id" },
            { title: "Model", field: "model" },
            { title: "Color", field: "color" },
            { title: "Type", field: "type" },
            { title: "Plate", field: "plate" },
            { title: "Owner", field: "owner" },
            { title: "Impounded", field: "impounded" },
            { title: "Stolen", field: "stolen" }
        ];
        html = renderTable(data, headers);
    } else if (currentTab === "warrants") {
        // Warrants
        const headers = [
            { title: "ID", field: "id" },
            { title: "Suspect", field: "suspect_name" },
            { title: "Reason", field: "reason" },
            { title: "Notes", field: "notes" },
            { title: "Date Issued", field: "date_issued" },
            { title: "Issued By", field: "issued_by" },
            { title: "Priority", field: "priority" }
        ];
        html = renderTable(data, headers);
    } else if (currentTab === "tickets") {
        // Tickets
        const headers = [
            { title: "ID", field: "id" },
            { title: "Issued To", field: "issued_to" },
            { title: "Issued By", field: "issued_by" },
            { title: "Incident", field: "incident" },
            { title: "Amount Due", field: "amount_due" }
        ];
        html = renderTable(data, headers);
    }
    content.innerHTML = html;
}

function switchTab(tab) {
    currentTab = tab;
    showAddButtons();
    fetchData(tab);
}

function fetchData(tab) {
    fetch(`https://${GetParentResourceName()}/fetchData`, {
        method: "POST",
        headers: { "Content-Type": "application/json; charset=UTF-8" },
        body: JSON.stringify({ category: tab })
    });
}

function openAddVehicleMenu() {
    fetch(`https://${GetParentResourceName()}/openAddVehicleMenu`, {
        method: "POST",
        headers: { "Content-Type": "application/json; charset=UTF-8" },
        body: JSON.stringify({})
    });
}
function openAddWarrantMenu() {
    fetch(`https://${GetParentResourceName()}/openAddWarrantMenu`, {
        method: "POST",
        headers: { "Content-Type": "application/json; charset=UTF-8" },
        body: JSON.stringify({})
    });
}
function openAddTicketMenu() {
    fetch(`https://${GetParentResourceName()}/openAddTicketMenu`, {
        method: "POST",
        headers: { "Content-Type": "application/json; charset=UTF-8" },
        body: JSON.stringify({})
    });
}

window.addEventListener("message", (event) => {
    const data = event.data;
    if (data.type === "hideContainer") {
        document.getElementById("container").style.display = "none";
        return;
    }
    if (data.type === "showContainer") {
        document.getElementById("container").style.display = "block";
        return;
    }
    
    if (data.type === "openUI") {
        document.body.style.display = "block";
        showAddButtons();
    } else if (data.type === "updateCitizens" && currentTab === "citizens") {
        updateContent(data.data);
    } else if (data.type === "updateVehicles" && currentTab === "vehicles") {
        updateContent(data.data);
    } else if (data.type === "updateWarrants" && currentTab === "warrants") {
        updateContent(data.data);
    } else if (data.type === "updateTickets" && currentTab === "tickets") {
        updateContent(data.data);
    }
});

// Close button
document.getElementById("closeBtn").addEventListener("click", function() {
    fetch(`https://${GetParentResourceName()}/closeUI`, {
        method: "POST",
        headers: { "Content-Type": "application/json; charset=UTF-8" },
        body: JSON.stringify({})
    });
    document.body.style.display = "none";
});
