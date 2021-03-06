describe("with a list of tasks", function() {
  
  beforeEach(function() {
    jasmine.addMatchers(customMatchers);
    table = affix("table");
    table.affix("tr.task#task_1 a.up");
    table.affix("tr.task#task_2 a.up+a.down");
    table.affix("tr.task#task_3 a.up");
    this.server = sinon.fakeServer.create();
    this.server.fakeHTTPMethods = true;
  });
  
  afterEach(function() {
    this.server.restore;
  });
  
  describe("with a successfull Ajax call", function() {
    
    beforeEach(function() {
      this.server.respondWith("PATCH", "/tasks/2/up.js",
        "{task_id: 2, new_order: 1}");
    });
    
    it("invokes a callback on success", function() {
      spyOn(Project, "successfullUpdate").and.callThrough();
      $("#task_2 .up").click();
      this.server.respond();
      expect(Project.successfullUpdate).toHaveBeenCalled();
    });
  });
  
  describe("with an unsuccessfull Ajax call", function() {
    
    beforeEach(function() {
      this.server.respondWith("PATCH", "/tasks/2/up.js",
        [500, {}, ""]);
    });
    
    it("invokes a callback on failure", function() {
      spyOn(Project, "failedUpdate").and.callThrough();
      $("#task_2 .up").click();
      this.server.respond();
      expect(Project.failedUpdate).toHaveBeenCalled();
    });
  });
  
  it("correctly processes an up click", function() {
    $("#task_2 .up").click();
    expect($("tr")).toMatchDomIds(["task_2", "task_1", "task_3"]);
  });
  
  it("correctly processes a down click", function() {
    $("#task_2 .down").click();
    expect($("tr")).toMatchDomIds(["task_1", "task_3", "task_2"]);
  });

});