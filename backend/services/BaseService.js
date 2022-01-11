class BaseService {
  constructor(model) {
    this.model = model;
  }

  async insert(data) {
    const created = await new this.model(data);
    return created.save();
  }

  async load() {
    return this.model.find();
  }

  async get(id) {
    return this.model.findById(id);
  }

  async update(id, data) {
    return this.model.findByIdAndUpdate(id, data, { new: true });
  }

  async getOne(condition) {
    return this.model.findOne(condition);
  }

  async remove(id) {
    return this.model.findByIdAndDelete(id);
  }

  async updateOne(condition, data) {
    return this.model.findOneAndUpdate(condition, data, { new: true });
  }
}

module.exports = BaseService;
