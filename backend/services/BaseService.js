const httpStatus = require("http-status");
const ApiError = require("../errors/ApiError");

class BaseService {
  constructor(model) {
    this.model = model;
  }

  async insert(data) {
    try {
      const created = await new this.model(data);

      return created.save();
    } catch (error) {
      throw new ApiError(
        "Something went wrong while inserting data to database",
        httpStatus.NOT_FOUND
      );
    }
  }

  async load(data) {
    try {
      return await this.model.find({}, {}, data);
    } catch (error) {
      throw new ApiError(
        "Something went wrong while loading datas from database ",
        httpStatus.NOT_FOUND
      );
    }
  }

  async get(id) {
    try {
      return this.model.findById(id);
    } catch (error) {
      throw new ApiError(
        "Something went wrong while fetching data from database ",
        httpStatus.NOT_FOUND
      );
    }
  }
  x;
  async getCon(condition) {
    return this.model.find(condition);
  }

  async update(id, data) {
    try {
      return this.model.findByIdAndUpdate(id, data, { new: true });
    } catch (error) {
      throw new ApiError(
        "Something went wrong while updating data to database ",
        httpStatus.NOT_FOUND
      );
    }
  }

  async updateAll(condition, data) {
    try {
      return await this.model.update(condition, data, { new: true });
    } catch (error) {
      throw new ApiError(error.message, httpStatus.NOT_FOUND);
    }
  }

  async getOne(condition) {
    try {
      return this.model.findOne(condition);
    } catch (error) {
      throw new ApiError(
        "Something went wrong while fetching data from database ",
        httpStatus.NOT_FOUND
      );
    }
  }

  async getAll(condition) {
    try {
      return this.model.find(condition);
    } catch (error) {
      throw new ApiError(
        "Something went wrong while fetching data from database ",
        httpStatus.NOT_FOUND
      );
    }
  }

  async remove(id) {
    try {
      return this.model.findByIdAndDelete(id);
    } catch (error) {
      throw new ApiError(
        "Something went wrong while removing data from database ",
        httpStatus.NOT_FOUND
      );
    }
  }

  async updateOne(condition, data) {
    try {
      return this.model.findOneAndUpdate(condition, data, { new: true });
    } catch (error) {
      throw new ApiError(
        "Something went wrong while updating data to database ",
        httpStatus.NOT_FOUND
      );
    }
  }
}

module.exports = BaseService;
