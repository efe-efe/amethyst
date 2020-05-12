function ProgressBar(id, parent, data){
    this.id = id;
    this.cell_width = null;

    var foreground_color = data.foreground_color || "#FAFAFA";
    var background_color = data.background_color || "rgba(36, 42, 53, 0.8)";
    var delayed = data.delayed || false;
    var show_value = data.show_value || false;

    this.parent = parent;

    this.panel = $.CreatePanelWithProperties("Panel", parent, "id", {
        id: id,
        class: "ProgressBar",
        hittest: "false",
        hittestchildren: "false"
    });

    this.resizable_panel = $.CreatePanelWithProperties("Panel", this.panel, "id", {
        class: "ProgressBar__Resizable",
        id: "ProgressBar__Resizable",
        hittest: "false",
        hittestchildren: "false"
    });

    this.fixed_panel = $.CreatePanelWithProperties("Panel", this.panel, "id", {
        class: "ProgressBar__Fixed",
        id: "ProgressBar__Fixed",
        hittest: "false",
        hittestchildren: "false"
    });

    this.background_panel = $.CreatePanelWithProperties("Panel", this.resizable_panel, "id", {
        id: "ProgressBar__Background",
        class: "ProgressBar__Background",
        hittest: "false",
        hittestchildren: "false"
    });

    this.text_panel = $.CreatePanelWithProperties("Label", this.fixed_panel, "id", {
        id: "ProgressBar__Text",
        class: "ProgressBar__Text",
        hittest: "false",
        hittestchildren: "false",
        text: "-"
    });
    
    this.cells_panel = $.CreatePanelWithProperties("Panel", this.fixed_panel, "id", {
        id: "ProgressBar__Cells",
        class: "ProgressBar__Cells",
        hittest: "false",
        hittestchildren: "false"
    });
        
    this.delay_panel = $.CreatePanelWithProperties("Panel", this.background_panel, "id", {
        id: "ProgressBar__Delay",
        class: "ProgressBar__Delay",
        hittest: "false",
        hittestchildren: "false"
    });

    this.foreground_panel = $.CreatePanelWithProperties("Panel", this.background_panel, "id", {
        id: "ProgressBar__Foreground",
        class: "ProgressBar__Foreground",
        hittest: "false",
        hittestchildren: "false"
    });

    this.foreground_panel.style.width = "0%";
    this.delay_panel.style.visibility = delayed && "visible" || "collapse";
    this.text_panel.style.visibility = show_value && "visible" || "collapse";

    this.background_panel.style.backgroundColor = background_color;
    this.foreground_panel.style.backgroundColor = foreground_color;
}
ProgressBar.prototype.SetTotalWidth = function(width){
    this.panel.style.width = width + "%";
} 
ProgressBar.prototype.SetPanelWidth = function(width){
    this.resizable_panel.style.width = width + "%";
}
ProgressBar.prototype.SetProgress = function(progress){
    this.foreground_panel.style.width = progress.toString() + "%";
    this.delay_panel.style.width = progress.toString() + "%";
}
ProgressBar.prototype.SetValue = function(value){
    this.text_panel.text = value;
}
ProgressBar.prototype.SetForegroundColor = function(color){
    this.foreground_panel.style.backgroundColor = color;
}
ProgressBar.prototype.SetVisibility = function(visibility){
    this.panel.style.visibility = visibility;
}
ProgressBar.prototype.SetBorder = function(data){
    if(data.left){
        this.background_panel.style.borderLeft = data.left + "px solid rgb(36, 42, 53);";
    }
    if(data.right){
        this.background_panel.style.borderRight = data.right + "px solid rgb(36, 42, 53);";
    }
    if(data.top){
        this.background_panel.style.borderTop = data.top + "px solid rgb(36, 42, 53);";
    }
    if(data.bottom){
        this.background_panel.style.borderBottom = data.bottom + "px solid rgb(36, 42, 53);";
    }
}
ProgressBar.prototype.SetCellWidth = function(width){
    if(width == this.cell_width){
        return;
    }

    this.cell_width = width;
    for(var i = 0; i < this.cells_panel.GetChildCount(); i++){
        $.Msg("AQUI DESTRUYENDO AL HIJO: ", i)
    }

    for(var i = 0; i < parseInt(this.panel.style.width.split("%")[0],10); i = i + this.cell_width){
        $.Msg("i = ", i, " cell width = ", this.cell_width)

        var cell = $.CreatePanelWithProperties("Panel", this.cells_panel, "id", {
            class: "ProgressBar__Cell",
            hittest: "false",
            hittestchildren: "false"
        });
        cell.style.width = this.cell_width.toString() + "%";

        if(i == 0){
            cell.style.borderLeft = 0;
        }
    }
}
ProgressBar.prototype.GetProgress = function(){
    return parseInt(this.foreground_panel.style.width.split("%")[0], 10)
}